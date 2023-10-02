class PagesController < ApplicationController
  layout 'marketing'

  def root
  end

  def dashboard
    render 'dashboard', layout: 'application'
  end
end
