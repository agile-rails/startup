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
# Agile controls for Diary application
######################################################################
module DiaryControl

###########################################################################
# Allow only current user documents to be selected
###########################################################################
def default_filter
  order = agile_sort_options(Diary) || { id: :desc }
  agile_filter_options(Diary).where(ar_user_id: session[:user_id]).order(order)
end

###########################################################################
# Default time begin
###########################################################################
def new_record
  @record.time_begin = Time.now
end

###########################################################################
# Process selected documents
###########################################################################
def process_checked
  processed = params[:checked].inject([]) do |r, record_id|
    r << record_id
  end
  flash[:info] = "Records #{processed.join(', ')} were processed"
  render json: { reload: true }
end

end
