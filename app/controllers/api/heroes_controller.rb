class Api::HeroesController < ApplicationController
  include Authenticable

  before_action :authenticable_with_token
  before_action :set_hero, only: [:show, :update, :destroy]
  respond_to :json

  # GET /heroes
  def index
    @heroes = Hero.by_token(@token).search(params[:term]).sorted_by_name

    respond_to do |f|
      f.json {render json: @heroes, status: :ok}
    end
  end

  # GET /heroes/1
  def show
    unless @hero == []
      render json: @hero, status: :ok
    else
      render json: @hero, status: :not_found
      end
  end

  # POST /heroes
  def create
    @hero = Hero.new(hero_params.to_h.merge!({token: @token}))

    if @hero.save
      render json: @hero, status: :created, location: api_hero_url(@hero)
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heroes/1
  def update
    if @hero.update(hero_params)
      render json: @hero
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  # DELETE /heroes/1
  def destroy
    @hero.destroy
    render json: "", status: :des
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      begin
        @hero = Hero.by_token(@token).find(params[:id])
      rescue
        @hero = []
      end
    end

    # Only allow a list of trusted parameters through.
    def hero_params
      params.require(:hero).permit(:name)
    end
end
