module Spree
  class PagSeguroController < ApplicationController
    protect_from_forgery :except => [:notify]
    
    def notify
      email = Spree::PagSeguro::Config.email
      token = Spree::PagSeguro::Config.token
      notification_code = params[:notificationCode]
      notification = ::PagSeguro::Notification.new(email, token, notification_code)
      
      if notification.approved?
        order = Spree::Order.find(notification.id)
      end
    end
    
    def callback
    end
  end
end