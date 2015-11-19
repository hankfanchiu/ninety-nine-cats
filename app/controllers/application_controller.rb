class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    current_session_token = session[:session_token]
    @current_user ||= User.find_by(session_token: current_session_token)
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def prevent_signup_or_login_if_logged_in
    redirect_to cats_url if current_user
  end

  def ensure_current_user_is_cat_owner
    cat_id = params[:id]
    found_cat = current_user.cats.where(id: cat_id)
    redirect_to cats_url if found_cat.empty?
  end
end
