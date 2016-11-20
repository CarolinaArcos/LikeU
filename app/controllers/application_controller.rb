class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Verify if user is logged in in the platform, ! interrupts the process.
  def authenticate!
    not_authorized() unless logged_in?()
  end

  private

  # Return current_user if exist, if not, search in User with :user_id if it's not nil
  def current_user
    return @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
  end

  def logged_in?
    return true if current_user().present?
  end

  def not_authorized(message = "No autorizado")
    redirect_to root_url, alert: message
  end

  def redirect_to_my_profile!
    redirect_to user_path(current_user) if logged_in?
  end


  # This methods can be call from any view
  helper_method :current_user, :logged_in?

end
