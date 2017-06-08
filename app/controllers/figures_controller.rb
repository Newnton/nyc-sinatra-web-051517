class FiguresController < ApplicationController
  get '/' do

  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @new_figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      new_title = Title.create(name: params[:title][:name])
      @new_figure.titles << new_title
    end

    if !params[:landmark][:name].empty?
      new_landmark = Landmark.create(name: params[:landmark][:name])
      @new_figure.landmarks << new_landmark
    end
    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  put '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    # save the figure

    # do you need to create a landmark?

    # associate landmark with the figure?

    if !params[:landmark][:name].empty?
      updated_landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << updated_landmark
    end

    if !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end


    erb :"/figures/show"
  end

  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/:id' do
    figure_id = params[:id].to_i
    if Figure.pluck(:id).include?(figure_id)
      @figure = Figure.find(params[:id])
      erb :"/figures/show"
    else
      erb :"/application/404"
    end
  end


end
