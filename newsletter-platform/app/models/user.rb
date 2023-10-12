class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :newsletters, foreign_key: :author_id, dependent: :destroy
  has_many :issues, through: :newsletters
  has_many :accounts, foreign_key: :author_id, dependent: :destroy
end
