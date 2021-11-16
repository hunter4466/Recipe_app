class FoodsController < ApplicationController
  def show
    @foods = Food.all
    @user = current_user.id
  end

  def new
    @food = Food.new
    @user = current_user.id
  end

  def create
    @food = Food.new
    @food.name = params[:food][:name]
    @food.measurement_unit = params[:food][:measurement_unit]
    @food.price = params[:food][:price]
    @food.user_id = params[:user_id]
    if @food.save
      redirect_to foods_show_url()
    else
      flash.now[:error] = 'To-do item update failed'
      render :new
    end
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
