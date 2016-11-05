Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root("sessions#new")

  resources(:sessions, only: [:create, :new, :destroy])

  resources(:users, except: [:destroy])

  resources(:questions, only: [:show]) do
    resources(:answers, only: [:create, :update])
  end
end
