class WatchlistController < ApplicationController

  def index
    @movies = Movie.all
  end

  def all
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to watchlists_path, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to watchlists_path, notice: 'movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to watchlists_path, notice: 'movie was successfully destroyed.'
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :overview, :poster)
  end
end
