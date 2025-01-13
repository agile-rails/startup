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

#############################################################################
# Diary. Simple time-tracking and notes application tabel.
#############################################################################
class Diary < ApplicationRecord

validates :title,      presence: true
validates :time_begin, presence: true
validates :duration,   presence: true 

before_save :fill_search_field
 
#############################################################################
# Before save remove html tags from body field and save title + body into search field.
#############################################################################
def fill_search_field
  text = ActionView::Base.full_sanitizer.sanitize(body, tags: []).to_s
  text.gsub!(/[,.)(:;?]/, '')
  text.gsub!('&#13;',' ')
  text.gsub!('&gt;',' ')
  text.gsub!('&lt;',' ')
  self.search = "#{title} #{text}".squish.downcase.split(' ').uniq.join(' ')
end

end
