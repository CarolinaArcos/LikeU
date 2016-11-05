class UsersController < ApplicationController

  before_action :authenticate!, only: [:show]

  def new
    @user = User.new
  end

  def create
  end

  def show
    @question = current_user.get_last_answer.question.section.questions.last unless current_user.get_last_answer.nil?
    @question ||= Section.first.questions.first
  end

  def update
    @user = User.find(params[:id])
    @user.is_active = true
    if @user.update(user_params)
      redirect_to(user_path(@user))
    else
      render(:edit)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def get_current_section

  end



  private

  def user_params
    return params.require(:user).permit(
      :complete_in_days
    )
  end

end
