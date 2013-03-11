Wikiwalk::Application.routes.draw do
  get "admin/add_game"
  
  get "welcome/contact"
  get "welcome/how"
  get "welcome/idea"
  get "welcome/index"
  get "welcome/invite"
  get "welcome/register"
  get "welcome/suggest"
  post "welcome/suggest"

  get "play/wiki"
  get "play/index"
  get "play/random"
  get "play/featured"
  get "play/custom"
  get "play/complete"
  
  get "admin/add_game"
  post "admin/add_game"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'welcome#index'

end
