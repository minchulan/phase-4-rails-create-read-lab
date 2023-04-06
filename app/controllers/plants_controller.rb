class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity 
    # get '/plants'
    def index
        render json: Plant.all, status: :ok 
    end 

    # get '/plants/:id'
    def show
        plant = Plant.find_by(id: params[:id])
        render json: plant 
    end 

    # post '/plants'
    def create 
        plant = Plant.create!(plant_params)
        render json: plant, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {error: invalid.record.errors}, status: :unprocessable_entity 
    end 

    private 

    def plant_params 
        params.permit(:name, :image, :price)
    end 

end
