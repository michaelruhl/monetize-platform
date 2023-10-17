class PagesController < ApplicationController
  layout 'marketing'

  def root
  end

  def dashboard
    @newsletters = Newsletter.all
    @subscribed_newsletters = []
    @issues = Issue.all

    render 'dashboard', layout: 'application'
  end
end
