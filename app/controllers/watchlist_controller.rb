class WatchlistController < ApplicationController

  def index
    @movies = Movie.all
  end

  def lists
    @lists = List.all
  end

  def list
    @list = List.find(params[:id])
  end

  def all
    @movies = Movie.all
  end

  def add_movie_to_list
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:movie_id])
    addedmovie = Addedmovie.new(list: @list, movie: @movie)
    addedmovie.save
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def add_to_list
    @movie = Movie.find(params[:id])
    @lists = List.all
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
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to watchlists_path, notice: 'list was successfully updated.'
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

  def list_params
    params.require(:list).permit(:name)
  end

end
