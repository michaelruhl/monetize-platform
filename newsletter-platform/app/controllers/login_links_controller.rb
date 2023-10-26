class LoginLinksController < ApplicationController
    before_action :authenticate_user!

    def create
        account = current_user.accounts.find_by(stripe_account_id: params[:account_id])
        login_link = Stripe::Account.create_login_link(account.stripe_account_id)

        redirect_to login_link.url, allow_other_host: true
    end
end
