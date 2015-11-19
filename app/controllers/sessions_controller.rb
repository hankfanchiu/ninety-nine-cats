class SessionsController < ApplicationController
  before_action :prevent_signup_or_login_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :login
  end

  def create
    username, password = session_params[:username], session_params[:password]
    @user = User.find_by_credentials(username, password)
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = "Login failed"
      render :login
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end

    redirect_to cats_url
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
