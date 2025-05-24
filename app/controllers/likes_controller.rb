class LikesController < ApplicationController
  before_action :authenticate_user
  
  def create
    @likeable = find_likeable
    
    # Vérifie si l'utilisateur a déjà liké cet élément
    existing_like = Like.find_by(user: current_user, likeable: @likeable)
    
    if existing_like
      # Si un like existe déjà, on le supprime (unlike)
      existing_like.destroy
      flash[:success] = "Vous avez retiré votre like"
    else
      # Sinon, on crée un nouveau like
      @like = Like.new(user: current_user, likeable: @likeable)
      
      if @like.save
        flash[:success] = "Vous avez liké ce contenu"
      else
        flash[:danger] = "Erreur lors du like"
      end
    end
    
    # Redirige vers la page appropriée
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def find_likeable
    if params[:gossip_id]
      Gossip.find(params[:gossip_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end
end