Spree::Core::Engine.routes.prepend do
  post "pag_seguro/confirm", :to => "pag_seguro#confirm"
  get "pag_seguro/callback", :to => "pag_seguro#callback"
  resources :payment_notifications, :only => [:create]
end