Rails.application.routes.draw do
  get 'foods/show', to: "foods#show", as: "foods_show"
  get 'foods/shop', to: "foods#shop", as: "foods_shop"
  get 'foods/new', to: "foods#new", as: "foods_new"
  get 'recipes/new', to: "recipes#new", as: "recipes_new"
  get 'recipes/show', to:  "recipes#show", as: "recipes_show"
  get "/users/:user_id/recipes/:id", to: "recipes#details", as: "user_recipe_details"
  get 'recipes/public', to:  "recipes#public", as: "recipes_public"
  post "/recipes/:id/update/public", to: "recipes#recipepublic", as: "user_recipe_update_public"
  post 'recipes/:user_id/food/new/:id', to: "recipes#addrecipefood", as: "add_food_recipe"
  post "/users/:user_id/food", to: "foods#create", as: "user_create_food"
  post "/users/:user_id/recipe", to: "recipes#create", as: "user_create_recipe"
  delete "/users/foods/:id", to: "foods#destroy", as: "user_destroy_food"
  delete "/users/recipes/:id", to: "recipes#destroy", as: "user_destroy_recipe"
  devise_for :users
  root to: "recipes#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
