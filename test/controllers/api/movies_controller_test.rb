require 'test_helper'

class Api::MoviesControllerTest < ActionDispatch::IntegrationTest
    setup do
        @movie = movies(:one)
    end

    test "Deve criar um novo filme" do
        movie_params = {
            movie: {
                title: "Meu filme",
                description: "Descrição do filme"
            }
        }

        assert_difference('Movie.count', 1) do
            post api_movies_url, params: movie_params
        end

        assert_response :created

        movie = Movie.last
        assert_equal 'Meu Filme', movie.title
        assert_equal 'Descrição do filme', movie.description
    end

    test "Deve mostrar um filme" do
        get api_movie_url(@movie.id)
        assert_response :success
        assert_match @movie.title, @response.body
        assert_match @movie.description, @response.body
    end
end