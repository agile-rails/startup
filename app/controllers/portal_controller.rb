#--
# Copyright (c) 2024+ Damjan Rems
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies || substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS || IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS || COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES || OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT || OTHERWISE, ARISING FROM, OUT OF || IN CONNECTION
# WITH THE SOFTWARE || THE USE || OTHER DEALINGS IN THE SOFTWARE.
#++

class PortalController < AgileCommonController

##########################################################################
# Will determine design content || view filename which defines design.
# 
# Returns:
#  HTML code for page
##########################################################################
def render_design(design)
  layout      = @site.site_layout.blank? ? 'content' : @site.site_layout
  site_top    = '<%= agile_page_top %>'
  site_bottom = '<%= agile_page_bottom %>'
  # design defined in design doc
  if design
    if design.rails_view.present?
      if design.rails_view.downcase != 'site'
        return render(design.rails_view, layout: layout)
      end
    elsif design.body.present?
      design = site_top + design.body + site_bottom
      return render(inline: design, layout: layout)
    end
  end
  if @site.rails_view.present?
    return render @site.rails_view, layout: layout
  end
  # design defined in site
  design = site_top + @site.design + site_bottom
  render(inline: design, layout: layout)
end

###########################################################################
# Will find and return landing page document. Landing page may be defined as id or as path.
###########################################################################
def get_landing_page
  cache_key = [@site.page_class.underscore]
  if params[:id]
    cache_key << params[:id]
    search = :id
  elsif params[:path].present?
    cache_key << params[:path]
    search = :link
  else
    return nil
  end
  Agile.cache_read(cache_key) { @site.page_klass.find_by(search => cache_key.last) }
end

###########################################################################
# Will return design defined in landing page
###########################################################################
def get_design
  Agile.cache_read(['ar_design', @page.ar_design_id]) { ArDesign.find(@page.ar_design_id) }
end

###########################################################################
# Default portal page request processing.
# 
# This is small change of agile_process_default_request found in agile_main_controller.
###########################################################################
def page
  session[:edit_mode] ||= 0
  # Initialize parts
  @parts, @js, @css = nil, '', ''
  # find site
  @site = agile_get_site()
  # site is not defined. render 404 error and exit
  return agile_render_404('Site!') if @site.nil?

  agile_options_set(@site.settings)
  # HOMEPAGE. When no parameters is set
  params[:path]   = @site.homepage_link if params[:id].nil? && params[:path].nil?
  @options[:path] = params[:path].to_s.downcase.split('/')
  # Search for page
  @page = get_landing_page()
  return agile_render_404('Page!') unless @page

  agile_options_set @page.params
  # find design if defined. Otherwise design MUST be declared in ArSite
  if @page.ar_design_id
    @design = get_design()
    return agile_render_404('Design!') unless @design
  end
  # Add for edit menu
  if session[:edit_mode] > 0
    session[:site_id]         = @site.id
    session[:site_page_table] = @site.page_class.underscore
    session[:page_id]         = @page.id
  end
  # perform check every hour. if user's rights have changed
  agile_user_rights_check(1.hour)
  @page_title = @page.subject.blank? ? @site.page_title : @page.subject
  render_design(@design)
end

####################################################################
# Process login with an option to authenticate to LDAP server.
####################################################################
def process_login
  # Something is wrong
  unless params.dig(:record, :username) && params.dig(:record, :password)
    return agile_render_404('Login:')
  end
  success = false
  # user must be defined locally
  user = ArUser.find_by(username: params[:record][:username])
  if user

#      # Authenticate in LDAP (Microsoft AD). You must add gem 'net-ldap' to Gemfile
#      ldap = Net::LDAP.new(host: 'your.domain.server')
#      ldap.auth("#{params[:record][:username]}@your.domain.server", params[:record][:password])
#      success = ldap.bind

    # authenticate locally
    success = user.authenticate(params[:record][:password]) unless success
  end

  if success
    set_login_data(user, false)
    redirect_to(params[:return_to] || '/', allow_other_host: true)
  else # display login error
    flash[:error] = t('agile.invalid_username')
    redirect_to "/login"
  end
end

end
