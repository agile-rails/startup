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

module PortalDashboardHelper

########################################################################
# Just writes out current user name
########################################################################
def dash_001_who_am_i
  dashboard_element(:info, 'WHO AM I', "Hello #{@user.name}. Information text example.") 
end

########################################################################
# Inform user that has some unfinished bussines in diary.
########################################################################
def dash_010_diary_status
  count = Diary.where(ar_user_id: @user_id, closed: false).count
  if count > 0
    text  = "#{link_to('Click', @server + '/diary')}, to review." 
    dashboard_element(:warning, "#{count} UNCLOSED documents in DIARY", text) 
  end
end

########################################################################
# Just some warning
########################################################################
def dash_020_a_warning
  dashboard_element(:warning, 'SOME WARNING', 'Warning text. Nothing comes to mind.')
end

########################################################################
# Simulating error dashboard element
########################################################################
def dash_030_error
  if @user.username == 'rems'
    dashboard_element(:info, 'HELLO MR. REMS', '')
  else
    dashboard_element(:error, 'YOU ARE NOT MR. REMS', 'This is error text example.')
  end    
end

end
