class AccountLinksController < ApplicationController
    before_action :authenticate_user!
    
    def create
      link =  Stripe::AccountLink.create(
      account: params[:account_id],
      refresh_url: new_account_url,
      return_url: account_url(params[:account_id]),
      type: 'account_onboarding',
      collect: 'eventually_due',
        )
        
        redirect_to link.url, allow_other_host: true
    end

end
