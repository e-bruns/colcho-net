class UserSessionsController < ApplicationController
  before_action :require_no_authentication, only: [:new, :create]
  before_action :require_authentication, only: :destroy

  def new
    # @session = UserSession.new(session)
  end

  def create
    user = User.authenticate(params.require(:email), params.require(:password))
    #user = User.find_by_email(params[:email])
    #if user.present? && user.authenticate(params[:password])
    if user.present?
      session[:user_id] = user.id
      redirect_to root_path, notice: t('.signed_in')
    else
      redirect_to login_path, alert: t('.sign_in_error')
      # render :new, alert: t('.sign_in_error')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('.logged_out')
  end

end