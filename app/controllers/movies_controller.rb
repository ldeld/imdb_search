class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # Search using only active record:
        #   sql_query = "movies.title @@ :query
        #   or movies.syllabus @@ :query
        #   or directors.first_name @@ :query
        #   or directors.last_name @@ :query"
        # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # Search using multisearch
        # @results = PgSearch.multisearch(params[:query]).map { |result| result.searchable }

      # Search using pg_search_scope
      @movies = Movie.search_by_title_and_syllabus(params[:query])
    else
      @movies = Movie.all
    end
  end

  def destroy
    @movie = Movie.search_by_title_and_syllabus
  end
end
