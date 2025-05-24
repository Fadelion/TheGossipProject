class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_gossip
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def create
    @comment = @gossip.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = "Commentaire ajouté avec succès !"
    else
      flash[:danger] = "Erreur lors de l'ajout du commentaire : #{@comment.errors.full_messages.join(', ')}"
    end
    
    redirect_to gossip_path(@gossip)
  end
  
  def edit
  end
  
  def update
    if @comment.update(comment_params)
      flash[:success] = "Commentaire mis à jour avec succès !"
      redirect_to gossip_path(@gossip)
    else
      flash.now[:danger] = "Erreur lors de la mise à jour du commentaire : #{@comment.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Commentaire supprimé avec succès !"
    redirect_to gossip_path(@gossip)
  end
  
  private
  
  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
  
  def set_comment
    @comment = @gossip.comments.find(params[:id])
  end
  
  def authorize_user
    unless @comment.user == current_user
      flash[:danger] = "Vous n'êtes pas autorisé à effectuer cette action"
      redirect_to gossip_path(@gossip)
    end
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end