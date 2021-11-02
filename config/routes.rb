# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'weather#show'

  get '/temperatures', to: 'temperatures#index'
  post '/temperatures', to: 'temperatures#upsert'
  get '/weather', to: 'weather#show'
end
