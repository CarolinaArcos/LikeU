class UsersController < ApplicationController

  before_action :authenticate!, only: [:show]

  def new
    @user = User.new
  end

  def create
  end

  # Determinates if the user can do a section and whichone
  def show
    # If the user is Starting the test
    if current_user.get_last_answer.nil?
      @question = Section.first.questions.first
      @is_able = true
    # If the user is in the last question of the test (Finishes all the sections)
  elsif current_user.finished_test?
      # Redirect to finalize page
      redirect_to(user_finalize_path(current_user))
    else
      #If the user had already started

      #If the user finished the section
      if current_user.finished_section?
        #If the user had completed the hour for the next section
        if current_user.hour_completed?
          # Sum the sections available each day until the current day from the array
          last_section_available = current_user.section_per_day[0..current_user.days_until_today].sum

          @question = current_user.get_last_answer.option.question.next
          # If the section is available to do today
          @is_able = true if @question.section.id <= last_section_available
        end
      else
        # Restarts the section if the user didn't finish it
        @question = Question.find(current_user.get_last_answer.option.question.section.questions.first) unless current_user.get_last_answer.nil?
        @is_able = true
      end
    end
  end

  #Update the user when it's modified (First time the user login)
  def update
    @user = User.find(params[:id])
    @user.is_active = true
    @user.started_at = DateTime.now
    if @user.update(user_params)
      # Redirect to profile
      redirect_to(user_path(@user))
    else
      render(:edit)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def finalize
    @data = current_user.results
    @show = current_user.show_figure?
  end

  private

  def user_params
    return params.require(:user).permit(
      :complete_in_days
    )
  end

end
