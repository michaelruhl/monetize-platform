class Customer < ApplicationRecord
  belongs_to :reader, class_name: 'User'
end
