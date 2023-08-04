class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Make current_user method available as a helper method for views
  helper_method :current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username name photo bio email password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name photo bio email password current_password])
  end

  def after_sign_in_path_for(_resource)
    # Replace 'user_path' with the path to the user page you want to redirect to.
    user_path(current_user)
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
