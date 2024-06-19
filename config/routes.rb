Rails.application.routes.draw do
  resources :applications, param: :token do
    resources :chats, only: [:create, :index, :show], param: :number do
      resources :messages, only: [:create, :index, :show], param: :id
      get 'search_messages', to: 'messages#search'
    end
  end
end

