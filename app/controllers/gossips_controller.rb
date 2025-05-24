class GossipsController < ApplicationController
  before_action :authenticate_user, except: [:index]
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def index
    @gossips = Gossip.all
  end

  def show
    @comment = Comment.new
    @comments = @gossip.comments
  end
  
  def new
    @gossip = Gossip.new
    @tags = Tag.all
  end
  
  def create
    @gossip = current_user.gossips.build(gossip_params)
    
    if @gossip.save
      flash[:success] = "Le potin a été sauvegardé avec succès !"
      redirect_to root_path
    else
      @tags = Tag.all
      flash.now[:danger] = "Erreur lors de la création du potin : #{@gossip.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @tags = Tag.all
  end
  
  def update
    if @gossip.update(gossip_params)
      flash[:success] = "Le potin a été mis à jour avec succès !"
      redirect_to gossip_path(@gossip)
    else
      @tags = Tag.all
      flash.now[:danger] = "Erreur lors de la mise à jour du potin : #{@gossip.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @gossip.destroy
    flash[:success] = "Le potin a été supprimé avec succès !"
    redirect_to root_path
  end
  
  private
  
  def set_gossip
    @gossip = Gossip.find(params[:id])
  end
  
  def authorize_user
    unless @gossip.user == current_user
      flash[:danger] = "Vous n'êtes pas autorisé à effectuer cette action"
      redirect_to gossip_path(@gossip)
    end
  end
  
  def gossip_params
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end
end