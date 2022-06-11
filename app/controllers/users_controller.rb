class UsersController < ApplicationController
  before_action :require_authentication, only: :show
  before_action :require_no_authentication, only: [:new, :create]
  before_action :can_change, only: [:edit, :update]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      SignupMailer.confirm_email(@user).deliver
      redirect_to @user, notice: I18n.t('users.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
        redirect_to @user, notice: I18n.t('users.update.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

  private

  def user_params
    params.require(:user).permit(:bio, :email, :full_name, :location, :password, :password_confirmation)
  end

  def can_change
    unless user_signed_in? && current_user == user
      redirect_to user_path(session[:user_id]), alert: t('user_sessions.not_authorized')
    end
  end

  def user
    @user ||= User.find(params[:id])
  end
end