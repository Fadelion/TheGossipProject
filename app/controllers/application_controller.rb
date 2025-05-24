class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Rend les méthodes disponibles pour les vues
  helper_method :current_user, :logged_in?
  
  # Retourne l'utilisateur actuellement connecté (s'il existe)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end
  
  # Retourne true si l'utilisateur est connecté, false sinon
  def logged_in?
    !current_user.nil?
  end
  
  # Vérifie si l'utilisateur est connecté, sinon redirige vers la page de connexion
  def authenticate_user
    unless logged_in?
      flash[:danger] = "Vous devez être connecté pour accéder à cette page"
      redirect_to login_path
    end
  end
end
