class Notice < ApplicationRecord
  belongs_to :user
  enum notice_type: { 'follow': 0, "first_login": 1 }.freeze
end
