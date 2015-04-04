require 'test_helper'

class GenresMoviesControllerTest < ActionController::TestCase
  setup do
    @genres_movie = genres_movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genres_movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genres_movie" do
    assert_difference('GenresMovie.count') do
      post :create, genres_movie: { genre_id: @genres_movie.genre_id, movie_id: @genres_movie.movie_id }
    end

    assert_redirected_to genres_movie_path(assigns(:genres_movie))
  end

  test "should show genres_movie" do
    get :show, id: @genres_movie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genres_movie
    assert_response :success
  end

  test "should update genres_movie" do
    patch :update, id: @genres_movie, genres_movie: { genre_id: @genres_movie.genre_id, movie_id: @genres_movie.movie_id }
    assert_redirected_to genres_movie_path(assigns(:genres_movie))
  end

  test "should destroy genres_movie" do
    assert_difference('GenresMovie.count', -1) do
      delete :destroy, id: @genres_movie
    end

    assert_redirected_to genres_movies_path
  end
end
