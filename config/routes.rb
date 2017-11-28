Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'newsletter/create'

  get '/galeria/:album', to: 'app/front#gallery', as: :app_gallery
  get '/somos', to: 'app/front#somos', as: :app_somos
  get '/ubicacion', to: 'app/front#ubicacion', as: :app_ubicacion

  get '/galeria', to: 'app/front#albums', as: :app_album

  get '/directorio', to: 'app/front#directorio', as: :app_directorio
  get '/directorio/categoria/:category', to: 'app/front#category', as: :directorio_category
  get '/directorio/:letter', to: 'app/front#directorio', as: :search

  get '/downloads', to: 'app/front#downloads', as: :downloads

  # get '/search/:query', to: 'app/front#search', as: :search_shop
  root to: 'app/front#index', as: :root
  devise_for :users, skip: KepplerConfiguration.skip_module_devise
  mount KepplerContactUs::Engine, :at => '/', as: 'messages'

  post 'newsletter/create', as: "newsletters"
  namespace :admin do
    resources :habitants do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :downloads do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :banners do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end


    resources :albums do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
        resources :photos do
          get '(page/:page)', action: :index, on: :collection, as: ''
          get '/clone', action: 'clone'
          delete(
            action: :destroy_multiple,
            on: :collection,
            as: :destroy_multiple
          )
        end
    end

    resources :categories do
      get '(page/:page)', action: :index, on: :collection,as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
      resources :shops do
        get '(page/:page)', action: :index, on: :collection, as: ''
        get '/clone', action: 'clone'
        delete(
          action: :destroy_multiple,
          on: :collection,
          as: :destroy_multiple
        )
      end
    end

    resources :customizes do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/install_default', action: 'install_default'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    root to: 'admin#root'

    resources :users do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :meta_tags do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :google_adwords do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :google_analytics_tracks do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :settings, only: [] do
      collection do
        get '/:config', to: 'settings#edit', as: ''
        put '/:config', to: 'settings#update', as: 'update'
        put '/:config/appearance_default', to: 'settings#appearance_default', as: 'appearance_default'
      end
    end
  end


  # Errors routes
  match '/403', to: 'errors#not_authorized', via: :all, as: :not_authorized
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Dashboard route engine
  mount KepplerGaDashboard::Engine, at: 'admin/dashboard', as: 'dashboard'
  mount KepplerBlog::Engine, :at => '/', as: 'blog'
end
