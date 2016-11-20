class AnswersController < ApplicationController
  before_action :authenticate!, only: [:create]

  def create
    @question = Question.find(params[:question_id])

    # Create a new answer and assigns the user, the question and the option selected
    @answer = Answer.create_or_initialize(@question, current_user)
    @answer.user = current_user
    @answer.question = @question
    @answer.option_id = answer_params[:option_id]


    if @answer.save
      if current_user.can_continue?
        # Redirect to the next question in the section
        redirect_to @question.next
      else
        # Redirect to profile page
        redirect_to current_user
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
