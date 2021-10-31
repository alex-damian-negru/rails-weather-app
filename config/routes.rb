# frozen_string_literal: true

Rails.application.routes.draw do
  root 'temperatures#index'

  post '/', to: 'temperatures#upsert'
end
