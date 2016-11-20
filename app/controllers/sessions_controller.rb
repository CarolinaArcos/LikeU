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
      # Create new session
      session[:user_id] = @session.id

      if @session.is_active?
        # Redirect to profile
        redirect_to  user_path(@session)
      else
        # Redirect to edit user
        redirect_to edit_user_path(@session)
      end
    end
  end

  # Logout
  def destroy
  end


end
