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
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

######################################################################
#
######################################################################
module DiaryReport

######################################################################
# Will collect data and write it to ArTemp collection and refresh view in return.
######################################################################
def collect_data
  clear_data
  query_data.each do | rec|
    write(time_begin: I18n.l(rec.time_begin),
          duration: rec.duration,
          title:    rec.title)
  end
  write(end: true)
  render json: { reload: 'if_ar_temp' }
end

private

######################################################################
# Return query to select data for report
######################################################################
def query_data
  date_from = params[:record][:date_from].to_time.localtime.beginning_of_day
  date_to   = params[:record][:date_to].to_time.localtime.end_of_day

  Diary.where("ar_user_id = ? and time_begin >= ? and time_begin <= ?", session[:user_id], date_from, date_to)
       .order(time_begin: 'asc')
end

end
