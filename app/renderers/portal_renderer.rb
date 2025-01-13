#--
# Copyright (c) 
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

########################################################################
#
########################################################################
class PortalRenderer < AgileRenderer
  
########################################################################
# Render login/logout links and currently logged in user's name
########################################################################
def login
  if @env.session[:user_id].nil?
%(
  <div class="portal-login">
  #{@env.link_to('LOGIN ', '/login')}
  </div>
)
  else
%(
  <div class="portal-login">
  #{@env.link_to('LOGOUT : ', { controller: :agile_common, action: :logout, return_to: '/login' } )}
  #{@env.session[:user_name]}&nbsp;
  </div>
)
  end
end

########################################################################
#
########################################################################
def default
  '<iframe id="iframe_edit" name="iframe_edit"></iframe>'
end

########################################################################
# Renderer dispatcher. Will skip access control for login.
########################################################################
def render_html
  method = @opts[:method] || 'default'
  unless method == 'login'
    can_view, msg = @env.agile_user_can_view(@env, @env.page)
    return msg unless can_view
  end
  respond_to?(method) ? send(method) : "#{self.class}: Method (#{method}) not defined!"
end

end
