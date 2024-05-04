class Api::MovieController < ApplicationController
    def index
        render json: { "message": 'Olá, mundo!' }
    end
end