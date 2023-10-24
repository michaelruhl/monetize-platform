class Newsletter < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :issues
  has_many :memberships, dependent: :destroy
end
