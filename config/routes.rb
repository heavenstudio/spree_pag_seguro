Spree::Core::Engine.routes.prepend do
  match "pag_seguro/notify", :to => "pag_seguro#notify", method: :post
  match "pag_seguro/callback", :to => "pag_seguro#callback", method: :get
  resources :payment_notifications, :only => [:create]
end