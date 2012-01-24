Spree::Core::Engine.routes.prepend do
  post "pag_seguro/confirm", :to => "pag_seguro#confirm", :method => :post
  get "pag_seguro/confirm", :to => "pag_seguro#confirm", :method => :get
  resources :payment_notifications, :only => [:create]
end