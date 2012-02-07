module Spree
  class PagSeguroController < Spree::CheckoutController
    protect_from_forgery :except => [:confirm]
    skip_before_filter :persist_gender
    
    def confirm
      email = Spree::PagSeguro::Config.email
      token = Spree::PagSeguro::Config.token
      notification_code = params[:notificationCode]
      notification = PagSeguro::Notification.new(email, token, notification_code)
      raise notification.inspect
      if notification.approved?
        order = Spree::Order.find(notification.id)
      end
    end
  end
end