# frozen_string_literal: true

Rails.application.routes.draw do
  root 'weather#show'

  put 'temperatures', to: 'temperatures#upsert'
end
