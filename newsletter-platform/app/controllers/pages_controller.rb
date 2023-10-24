class PagesController < ApplicationController
  layout 'marketing'

  def root
  end

  def dashboard
    @subscribed_newsletters = current_user.active_subscribed_newsletters
    @newsletters = Newsletter.where.not(id: @subscribed_newsletters.pluck(:id))
    @issues = Issue.where(newsletter: @subscribed_newsletters).order(created_at: :desc)

    render 'dashboard', layout: 'application'
  end
end
