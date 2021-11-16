class RecipesController < ApplicationController
  def new
  end

  def show
    @user = current_user.id
    @recipes = Recipe.all
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      # Post.update_post_counter(User.find(current_user.id))
      flash[:notice] = 'Recipe deleted succesfully'
    else
      flash[:error] = 'Recipe not deleted'
    end
    redirect_to recipes_show_url()
  end
end
