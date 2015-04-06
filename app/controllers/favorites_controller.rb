class FavoritesController < ApplicationController

  def index
  	@favorites = Favorite.all
  end

  def create
  	favorite_params = params.require(:favorite).permit(:recipe_id, :title)
	@favorite = Favorite.create(favorite_params)
	redirect_to favorites_path
  end

  def destroy
  	@favorite = Favorite.find(params[:id])
  	@favorite.destroy
  	redirect_to favorites_path
  end

end