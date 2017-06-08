class LandmarksController < ApplicationController
  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed].to_i)
    erb :'/landmarks/show'
  end

  get '/landmarks' do
    erb :'/landmarks/index'
  end

  get '/landmarks/:id/edit' do
    id = params[:id].to_i
    if Landmark.pluck(:id).include?(id)
      @landmark = Landmark.find(params[:id])
      erb :'/landmarks/edit'
    else
      erb :'/application/404'
    end
  end

  put '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update!(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed].to_i)
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

end
