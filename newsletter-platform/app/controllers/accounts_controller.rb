class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def show
    @account = current_user.accounts.find(params[:id])
  end

  def new
  end

  def create
    country = params[:account][:country].upcase
    account = Stripe::Account.create(
      type:'express',
      country: country,
      email: current_user.email,
      capabilities: {
        card_payments: {requested: true},
        transfers: {requested: true}
      },
      business_type: 'individual',
      business_profile: {
        mcc: '5815',
        name: current_user.name,
        product_description: 'Email newsletters',
        support_email: current_user.email,
        url: 'https://mikethedev.ca',
      },
      tos_acceptance: {
        service_agreement: country == 'US' ? 'full' : 'recipient',
      }
    )

    link = Stripe::AccountLink.create(
      account: account.id,
      refresh_url: new_account_url,
      return_url: account_url(account.id),
      type: 'account_onboarding',
      collect: 'eventually_due',
    )

    current_user.accounts.create!(
      stripe_account_id: account.id,
    )

    redirect_to link.url, allow_other_host: true
  end

  def edit
  end
end
