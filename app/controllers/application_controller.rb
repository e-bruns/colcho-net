class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  around_action :switch_locale

  helper_method :current_user, :current_user_verified?, :user_signed_in?, :require_authentication, :require_no_authentication

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
  
  private

  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_user_verified?
    if User.find_by(id: session[:user_id]) == User.find(params[:id])
      true
    else
      false
    end
  end
  
  def user_signed_in?
    #current_user != nil
    #User.where(id: session[:user_id]).present?
    session[:user_id].present?
  end

  def require_authentication
    unless user_signed_in?
      redirect_to login_path, alert: t('user_sessions.needs_login')
    end
  end

  def require_no_authentication
    redirect_to root_path if user_signed_in?
  end

end
