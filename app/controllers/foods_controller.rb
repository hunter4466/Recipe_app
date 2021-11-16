class FoodsController < ApplicationController
  def show
    @foods = Food.all
    @user = current_user.id
  end

  def new
  end

  def destroy
    @recipe = Food.find(params[:id])
    if @recipe.destroy
      # Post.update_post_counter(User.find(current_user.id))
      flash[:notice] = 'Food deleted succesfully'
    else
      flash[:error] = 'Food not deleted'
    end
    redirect_to foods_show_url()
  end
end
