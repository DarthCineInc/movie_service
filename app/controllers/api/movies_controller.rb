require 'json'

class Api::MoviesController < ApplicationController
    def index
        movies = Movie.all.map { |movie| movie_json(movie) }
        render json: movies.to_json
    end

    def show
        movie = Movie.find(params[:id])
        render json: movie_json(movie)
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Filme não encontrado' }, status: :not_found
    end

    def create
        movie = Movie.new(movie_create_params)

        
        if movie.save
            BunnyClient.push(movie_json(movie).to_json)
            render json: movie_json(movie), status: :created
        else
            render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
    end

    def destroy
        movie = Movie.find(params[:id])
        movie.destroy

        head :no_content
    end

    private
    
    def movie_create_params
        params.require(:movie).permit(:title, :description, :release_date, :duration, :image)
    end

    def movie_json(movie)
        movie_attributes = movie.as_json(except: [:created_at, :updated_at, :image])
        movie_attributes['image'] = movie.image.present? ? movie.image.url : ''
        movie_attributes
      end
end