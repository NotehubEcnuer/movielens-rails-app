class GenresMoviesController < ApplicationController
  before_action :set_genres_movie, only: [:show, :edit, :update, :destroy]

  # GET /genres_movies
  # GET /genres_movies.json
  def index
    @genres_movies = GenresMovie.all
  end

  # GET /genres_movies/1
  # GET /genres_movies/1.json
  def show
  end

  # GET /genres_movies/new
  def new
    @genres_movie = GenresMovie.new
  end

  # GET /genres_movies/1/edit
  def edit
  end

  # POST /genres_movies
  # POST /genres_movies.json
  def create
    @genres_movie = GenresMovie.new(genres_movie_params)

    respond_to do |format|
      if @genres_movie.save
        format.html { redirect_to @genres_movie, notice: 'Genres movie was successfully created.' }
        format.json { render :show, status: :created, location: @genres_movie }
      else
        format.html { render :new }
        format.json { render json: @genres_movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genres_movies/1
  # PATCH/PUT /genres_movies/1.json
  def update
    respond_to do |format|
      if @genres_movie.update(genres_movie_params)
        format.html { redirect_to @genres_movie, notice: 'Genres movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @genres_movie }
      else
        format.html { render :edit }
        format.json { render json: @genres_movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genres_movies/1
  # DELETE /genres_movies/1.json
  def destroy
    @genres_movie.destroy
    respond_to do |format|
      format.html { redirect_to genres_movies_url, notice: 'Genres movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genres_movie
      @genres_movie = GenresMovie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genres_movie_params
      params.require(:genres_movie).permit(:movie_id, :genre_id)
    end
end
