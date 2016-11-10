class UsersController < ApplicationController

  before_action :authenticate!, only: [:show]

  def new
    @user = User.new
  end

  def create
  end

  def show
    #Proxima seccion a la que debe ir
    @question = Question.find(current_user.get_last_answer.option.question.section.questions.first) unless current_user.get_last_answer.nil?
    @question ||= Section.first.questions.first

    @is_able = true

    #if @next_question.section.eql? self.option.question.section

    #time_after_answer = (current_user.answered_at - Date.today).to_i  unless current_user.answered_at.nil?
    #unless time_after_answer.nil?
    #  #TODO ..
    #else
    #  @is_able = true
    #end
    #@question = current_user.get_last_answer.question.section.questions.last unless current_user.get_last_answer.nil?
    #@question ||= Section.first.questions.first
  end

  def update
    @user = User.find(params[:id])
    @user.is_active = true
    @user.started_at = Date.today
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
