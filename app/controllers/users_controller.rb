class UsersController < ApplicationController

  before_action :authenticate!, only: [:show]

  def new
    @user = User.new
  end

  def create
  end

  def show
    #Apenas comienza
    if current_user.get_last_answer.nil?
      @question ||= Section.first.questions.first
      @is_able = true
    elsif current_user.get_last_answer.options.question.next.nil?
      #redirect_to
    else
      #Ya ha comenzado
      if current_user.finished_section #Si ya termino seccion
        if current_user.hour_completed? #Si ya completo la hora
          last_section_available = current_user.section_per_day[0...current_user.days_until_today].sum

          @question = current_user.get_last_answer.option.question.next
          @is_able = true if @question.section.id < last_section_available #Si la siguiente seccion esta disponible para hacerla hoy
        end
      else
        #Reinicia la seccion
        @question = Question.find(current_user.get_last_answer.option.question.section.questions.first) unless current_user.get_last_answer.nil?
        @is_able = true
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.is_active = true
    @user.started_at = DateTime.now
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
