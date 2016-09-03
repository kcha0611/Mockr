class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user, :current_question

  def require_logged_in
    redirect_to '/login' unless current_user
  end

  def current_question
    @current_question ||= Question.where(user_id: current_user.id)
  end
end
