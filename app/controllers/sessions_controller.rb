class SessionsController < ApplicationController
  # Login
  def new
  end

  # Login
  # Create the session using cokies
  def create
    @session = User.authenticate(params[:email], params[:password])

    if @session.nil?
      render plain: "Error usuario o contraseña"
    else
      session[:user_id] = @session.id

      if @session.is_active?
        redirect_to  user_path(@session)
      else
        redirect_to edit_user_path(@session)
      end
    end
  end

  # Logout
  def destroy
  end


end
