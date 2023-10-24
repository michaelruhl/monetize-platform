class Membership < ApplicationRecord
  belongs_to :newsletter
  belongs_to :reader, class_name: 'User'
end
