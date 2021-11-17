class RecipesController < ApplicationController
  def show
    @user = current_user.id
    @recipes = Recipe.all
  end

  def details
    @recipefood = RecipeFood.new
    @user = User.find(params[:user_id])
    @foods = Food.where("user_id = #{params[:user_id]}")
    @recipe_foods = RecipeFood.where("recipe_id = #{params[:id]}")
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def addrecipefood
    @recipefood = RecipeFood.new
    @recipefood.quantity = params[:recipe_food][:quantity]
    @recipefood.food_id = params[:recipe_food][:food_id]
    @recipefood.recipe_id = params[:id]
    if @recipefood.save
      flash[:notice] = 'Success'
    else
      flash.now[:error] = 'Ingredient could not be added'
    end
    redirect_to user_recipe_details_url(user_id: params[:user_id], id: params[:id])
  end

  def new
    @recipe = Recipe.new
    @user = current_user.id
  end

  def create
    @recipe = Recipe.new
    @recipe.name = params[:recipe][:name]
    @recipe.preparation_time = params[:recipe][:preparation_time]
    @recipe.cooking_time = params[:recipe][:cooking_time]
    @recipe.description = params[:recipe][:description]
    @recipe.user_id = params[:user_id]
    @recipe.public = false
    if @recipe.save
      redirect_to recipes_show_url
    else
      flash.now[:error] = 'To-do item update failed'
      render :new
    end
  end

  def public
    @recipes = Recipe.all
    @food = Food.all
    # @foods = Foods.includes(:user).order(created_at: :desc)

    # @posts = Post.joins(:author).where(author: { id: @user.id }).order(created_at: :desc)
    # @comments = Comment.includes(:author).order(created_at: :desc)
  end

  def recipepublic
    @recipe = Recipe.find(params[:id])
    @recipe.public = if @recipe.public
                       false
                     else
                       true
                     end
    if @recipe.save
      # Post.update_post_counter(User.find(current_user.id))
      flash[:notice] = 'Success'
    else
      flash[:error] = 'Error'
    end
    redirect_to user_recipe_details_url(user_id: current_user.id, id: params[:id])
  end

  def recipeprivate
    @recipe = Recipe.find(params[:id])
    @recipe.public = false
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      # Post.update_post_counter(User.find(current_user.id))
      flash[:notice] = 'Recipe deleted succesfully'
    else
      flash[:error] = 'Recipe not deleted'
    end
    redirect_to recipes_show_url
  end
end
