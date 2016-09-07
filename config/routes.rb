Rails.application.routes.draw do
  get 'pages/home'
  get '/aboutus' => 'aboutus#home'

  root to: 'pages#home'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :questions, only:[:index], :path => 'questions'
  resources :questions, only:[:new], :path => 'questions'

  post '/questions' => 'questions#create'

  post '/questions/:id' => 'answers#create'

  resources :questions, only: [:index, :show] do
    member do
      put "upvote" => "questions#upvote"
      put "downvote" => "questions#downvote"
    end
    resources :answers, only: [:new, :create, :show, :index] do
      resources :answercomments
    end
  end

  resources :questions, only: [:index, :show] do
    resources :comments, only: [:new, :index, :create, :destroy] do
    end
  end

  resources :answers, only: [:show, :index] do
    member do
      put "upvote" => "answers#upvote"
      put "downvote" => "answers#downvote"
    end
    resources :answercomments, only: [:index]
  end

  resources :comments do
    member do
      put "upvote" => "comments#upvote"
      put "downvote" => "comments#downvote"
    end
  end

  resources :answercomments do
    member do
      put "upvote" => "answercomments#upvote"
      put "downvote" => "answercomments#downvote"
    end
  end 

  post '/questions/:question_id/comments' => 'comments#create'

  # post '/questions/:question_id/answers/:answer_id/answercomments' => 'answercomments#create'

  # get 'upvote' => 'questions#upvote'
  # post 'questions/:id' => 'comments#new'

  # resources :questions, only: [:show, :index, :new, :create] do
  #   member do
  #     post "upvote"
  #     post "downvote"
  #   end
  # end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
