class RecipesController < ApplicationController

	def index
		if params[:search]
	    search = params[:search].gsub(' ', '+')
	    response = HTTParty.get("http://food2fork.com/api/search?key=c7b146091210a08d9ee009718403b07b&q=#{search}")
	    #response = HTTParty.get("http://api.bigoven.com/recipes?title_kw=#{search}&pg=1&rpp=20&api_key=dvxNuGNi8Bu6O05x6mCh6uufAq5UT4g3")
	    #require 'open-uri'
		#results= Nokogiri::XML(open("http://api.bigoven.com/recipes?title_kw=#{search}&pg=1&rpp=20&api_key=dvxNuGNi8Bu6O05x6mCh6uufAq5UT4g3"))
	    #response = HTTParty.get("https://api.edamam.com/search?q=#{search}&app_id=$42f1654f&app_key=$7ac2d5617a0ad130c4c7e75b74f814c6") 
	    results = JSON.parse(response.body)
	    @results = results['recipes']
	  else
	    @results = []
	  end
	end

	def show
		response = HTTParty.get("http://food2fork.com/view/#{params[:id]}")
  		@result = JSON.parse(response.body)
	end

	def search
		#response = HTTParty.get("http://food2fork.com/view/#{params[:id]}")
		response = HTTParty.get("http://food2fork.com/api/get?key=c7b146091210a08d9ee009718403b07b&rId=#{params[:id]}")
  		@result = JSON.parse(response.body)
  		@favorite = Favorite.find_by(recipe_id: params[:id])
  		if !@favorite 
    		@favorite = Favorite.new(recipe_id: @result['recipe'], title: @result['title'])
  		end
	end

end