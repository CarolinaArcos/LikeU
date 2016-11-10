class AnswersController < ApplicationController
  before_action :authenticate!, only: [:create]

  def create
    @question = Question.find(params[:question_id])

    @answer = Answer.create_or_initialize(@question, current_user)
    @answer.user = current_user
    @answer.question = @question
    @answer.option_id = answer_params[:option_id]

    if @answer.save
      current_user.answered_at = Date.today
      current_user.save!

      if current_user.can_continue?
        redirect_to @question.next
      else
        redirect_to current_user # Posible que esto falle
      end
    else
      render json: { errors: ['can not save the answer'] }
    end
  end

  def update
  end

  private

  def answer_params
    return params.require(:answer).permit(
      :option_id
    )
  end

end
