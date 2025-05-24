class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      # Connexion réussie
      session[:user_id] = user.id
      
      # Gestion du "Se souvenir de moi"
      if params[:session][:remember_me] == '1'
        remember(user)
      end
      
      flash[:success] = "Connexion réussie !"
      redirect_to root_path
    else
      # Échec de la connexion
      flash.now[:danger] = "Email ou mot de passe incorrect"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    # Oublie l'utilisateur persistant
    forget(current_user) if logged_in?
    
    # Supprime la session
    session.delete(:user_id)
    @current_user = nil
    
    flash[:success] = "Vous êtes déconnecté"
    redirect_to root_path
  end
  
  private
  
  # Mémorise un utilisateur dans un cookie persistant
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Oublie un utilisateur persistant
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end