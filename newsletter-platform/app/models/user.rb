class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :newsletters, foreign_key: :author_id, dependent: :destroy
  has_many :issues, through: :newsletters
  has_many :accounts, foreign_key: :author_id, dependent: :destroy

  has_many :memberships, foreign_key: :reader_id, dependent: :destroy
  has_many :customers, foreign_key: :reader_id, dependent: :destroy
  has_many :subscribed_newsletters, through: :memberships, source: :newsletter

  def active_subscribed_newsletters
    subscribed_newsletters.where('memberships.status = ?', 'active')
  end

  def stripe_customer_id
    if customers.empty?
      customer = Stripe::Customer.create(
        email: email,
      )
      customers.create!(stripe_customer_id: customer.id)
    end

    customers.first.stripe_customer_id
  end

  def stripe_account_id
    default_account&.stripe_account_id
  end

  def default_account
    accounts.find_by(default_account: true)
  end
end
