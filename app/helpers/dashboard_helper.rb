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

module DashboardHelper

########################################################################
# Initialize dashboard element
########################################################################
def dash_0
  @user     ||= ArUser.find(session[:user_id])
  @user_roles = []
  @dashboard  = {}
  @dashboard_js, @dashboard_footer = '', ''

  @server = '/'
end

########################################################################
# Adds one dashboard element to array of elements
########################################################################
def dashboard_element(type, title, text = '')
  @dashboard[type] ||= ''
  @dashboard[type] += %(
  <div class="#{type} panel">
    <div class="title">#{title}</div>
    <div class="text">#{text}</div>
  </div>)
end

########################################################################
# Creates new dashboard footer element.
#
# @param [String] code : Text (code) to be added to footer element.
########################################################################
def footer_element(code)
  @dashboard_footer += %(<div class="data">#{code}</div>)
end

########################################################################
# Collect all methods starting with dash_, sort them and execute them in order.
# That's how result order can be predictable and reused if needed resulting in
# faster dashboard creation.
########################################################################
def draw_dashboard(for_email = false)
  return '' unless session[:user_id]

  dash_methods = methods.select { |method| method.to_s.start_with?('dash_') }
  # collect dashboard data
  dash_methods.sort.each { |method| send(method) }

  html = [:error, :warning, :info].map{ |type| @dashboard[type].to_s }.join
  html += '<div style="clear: both;"></div>'
  html += %(<div class="footer">#{@dashboard_footer}</div>) unless @dashboard_footer.blank? || for_email
  html.html_safe
end

end
