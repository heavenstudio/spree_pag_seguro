module Spree
  class PagSeguroController < Spree::CheckoutController
    protect_from_forgery :except => [:confirm]
    skip_before_filter :persist_gender
    
    def notify
      email = Spree::PagSeguro::Config.email
      token = Spree::PagSeguro::Config.token
      notification_code = params[:notificationCode]
      notification = PagSeguro::Notification.new(email, token, notification_code)
      raise "###########################\n\n\n\n\n#{notification.inspect}\n\n\n\n\n###########################"
      if notification.approved?
        order = Spree::Order.find(notification.id)
      end
    end
    
    def callback
    end
  end
end