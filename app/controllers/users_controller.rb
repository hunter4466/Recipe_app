class UsersController < ApplicationController
  before_action :update_interactions

  def index
    @users = User.all
  end

  def show
  end
end
