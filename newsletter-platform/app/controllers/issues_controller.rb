class IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @issues = current_user.issues
  end

  def new
    @issue = Issue.new

  end

  def create
    @issue = current_user.issues.new(issue_params)
    if @issue.save
      redirect_to issues_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @issue = Issue.find(params[:id])
  end


  def edit
    @issue = current_user.issues.find(params[:id])
  end

  def update
    @issue = current_user.issues.find(params[:id])
    if @issue.update(issue_params)
      redirect_to issues_path
    else
      render :edit
    end
  end

  private
  def issue_params
    params.require(:issue).permit(:newsletter_id, :subject, :content, :published_at )
  end
end
