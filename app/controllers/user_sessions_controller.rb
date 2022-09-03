class UserSessionsController < ApplicationController
  before_action :require_no_authentication, only: [:new, :create]
  before_action :require_authentication, only: :destroy
  before_action :check_user, only: [:create]

  def new
    # @session = UserSession.new(session)
  end

  def create
    user = User.authenticate(params.require(:email), params.require(:password))
    #user = User.find_by_email(params.require(:email))
    # if user.present? || user.authenticate(params.require(:email), params.require(:password)) || user.confirmed_at != nil
    
    if user.present?
      session[:user_id] = user.id
      redirect_to root_path, notice: t('.signed_in')
    else
      redirect_to login_path, alert: t('.sign_in_error')
      # render :new, alert: t('.sign_in_error')
    end
    #if @user.confirmed_at = nil
      # @user = User.find(user.id)
      # redirect_to login_path, alert: t('.sign_in_confirmation_token_error', :link => SignupMailer.confirm_email(user).deliver)
      # redirect_to login_path, alert: t('.sign_in_confirmation_token_error', :link => link_to(:action => SignupMailer.confirm_email(@user).deliver, :method => :post))
    #else 
      # session[:user_id] = @user.id
      # redirect_to root_path, notice: t('.signed_in')
    #end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('.logged_out')
  end

  def resend_confirmation_token
    user = User.find_by_email(params[:email])
    SignupMailer.confirm_email(user).deliver
    redirect_to login_path, notice: t('user_sessions.sign_in_resent_confirmation')
  end

  private

  def check_user
    if User.find_by_email(params.require(:email)).present? && User.find_by_email(params.require(:email)).try(:authenticate, params.require(:password))
      @user = User.find_by_email(params.require(:email))
      unless @user.confirmed?
        redirect_to login_path, alert: t('.sign_in_confirmation_token_error_html', link: url_for(controller: "user_sessions", action: "resend_confirmation_token", email: @user.email))
      end
    else
      redirect_to login_path, alert: t('.sign_in_error')
    end
  end

end