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

######################################################################
# Controls file for Todo application
######################################################################
module TodoControl

###########################################################################
# Allow only current user's documents to be displayed
###########################################################################
def default_filter
  order = agile_sort_options(Todo) || { time: :desc }
  agile_filter_options(Todo).where(ar_user_id: session[:user_id]).order(order)
end

###########################################################################
# Check if record can be saved
###########################################################################
def before_save
  return unless @record.closed

  flash[:error] = t('agile.record_no_update')
  false
end

###########################################################################
# Close task
###########################################################################
def close_task
  doc = Todo.find(params[:id])
  doc.closed = true
  doc.save
  Agile.model_check(doc, true)

  render json: { window: :reload }
end

###########################################################################
# Is "close task" button active
###########################################################################
def self.close_button_active(env)
  !env.record.closed
end

end
