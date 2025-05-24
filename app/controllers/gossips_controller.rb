class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
    @comments = @gossip.comments
  end
  
  def new
    @gossip = Gossip.new
    @tags = Tag.all
  end
  
  def create
    @anonymous_user = User.find_by(first_name: "Anonymous") || User.first
    @gossip = Gossip.new(gossip_params)
    @gossip.user = @anonymous_user
    
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
    @gossip = Gossip.find(params[:id])
    @tags = Tag.all
  end
  
  def update
    @gossip = Gossip.find(params[:id])
    
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
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    
    flash[:success] = "Le potin a été supprimé avec succès !"
    redirect_to root_path
  end
  
  private
  
  def gossip_params
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end
end