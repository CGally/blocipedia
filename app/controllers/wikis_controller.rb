class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki.all)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

  if @wiki.save
    flash[:notice] = "Wiki was saved."
    redirect_to @wiki
  else
    flash.now[:alert] = "There was an error saving the wiki. Please try again."
    render :new
  end
end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    @users = User.all
    @collaborator = Collaborator.new
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
