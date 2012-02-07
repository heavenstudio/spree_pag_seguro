Spree::Core::Engine.routes.prepend do
  post "pag_seguro/confirm", :to => "pag_seguro#confirm"
  resources :payment_notifications, :only => [:create]
end