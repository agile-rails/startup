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

####################################################################
# This class contains various methods that are useful when working with my company.
####################################################################
class Company

####################################################################
# Will return array of users prepared for select input field
####################################################################
def self.users_by_role_for_select(role = 'Company users')
  role = ArRole.get_role(role)
  return [] if role.nil?

  ArUser.includes(:ar_user_roles)
        .where(ar_user_roles: { ar_role_id: role.id }, active: true)
        .order(:name)
        .map { [_1.name, _1.id] }
end

####################################################################
# Will return user with Company manager role.
####################################################################
def self.manager
  role = ArRole.get_role('Company manager')
  return if role.nil?

  ArUser.includes(:ar_user_roles)
        .where(ar_user_roles: { ar_role_id: role.id }, active: true)
        .first
end

end
