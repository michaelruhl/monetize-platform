class NewslettersController < ApplicationController
  # protect_from_forgery prepend: true
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!
  def index
    @newsletters = current_user.newsletters
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = current_user.newsletters.new(newsletter_params)
    if @newsletter.save
      redirect_to newsletters_path
    else
      render :new, status: :unprocessable_entity  
    end
  end  

  def edit
  @newsletter = current_user.newsletters.find(params[:id])
  end

  def update
    @newsletter = current_user.newsletters.find(params[:id])
    if @newsletter.update(newsletter_params)
      redirect_to newsletters_path
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:title)
  end
end
