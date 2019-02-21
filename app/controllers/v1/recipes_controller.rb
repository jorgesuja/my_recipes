class V1::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  # GET /recipes
  def index
    @recipes = paginate Recipe.joins(:amounts, :ingredients)
                             .includes(:amounts, amounts: :ingredient)
                             .all
                             
    render json: @recipes.map(&method(:map_recipe))
  end

  # GET /recipes/1
  def show
    render json: @recipe
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params.require(:recipe).permit(:name, :steps, :time, :difficulty)
    end

    def map_recipe(recipe)
      {
        name: recipe.name,
        steps: recipe.steps,
        difficulty: recipe.difficulty,
        ingredients: recipe.amounts.map do |amount|
          {
            name: amount.ingredient.name,
            amount: amount.amount 
          }
        end
      }
    end
end
