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

module TodoHelper

########################################################################
# Inform user that has some open reminders.
########################################################################
def dash_010_todo
  count = Todo.where(ar_user_id: session[:user_id], closed: false).count
  if count > 0
    text = "<button>#{link_to('Click', @server + 'todo')}</button> to review."
    dashboard_element(:warning, "#{count} OPEN reminders.", text)
  end
end

###########################################################################
# Returns state of todo request as icon and closed date if request is closed
###########################################################################
def todo_closed_state(record, value)
  return '' unless record.closed

  %(#{mi_icon('check-o')}#{AgileHelper.format_date_time(record.time_closed, 'd')})
end

end
