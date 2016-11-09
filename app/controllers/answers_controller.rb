class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      @next_question = Question.find(self.option.question.id + 1)
      if @next_question.section.eql? self.option.question.section
        redirect_to(question_path(@next_question))
      else
        #TODO change answered_at
        current_user.answered_at = Date.today
        current_user.save!
        #TODO send to user show
        #TODO start hour
      end
    else
      #render()
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
