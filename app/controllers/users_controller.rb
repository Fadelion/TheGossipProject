class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      # Connecte l'utilisateur après son inscription
      session[:user_id] = @user.id
      
      # Gestion du "Se souvenir de moi"
      if params[:user][:remember_me] == '1'
        remember(@user)
      end
      
      flash[:success] = "Bienvenue sur The Gossip Project !"
      redirect_to root_path
    else
      flash.now[:danger] = "Erreur lors de l'inscription : #{@user.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :age, :description, :city_id)
  end
  
  # Mémorise un utilisateur dans un cookie persistant
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end