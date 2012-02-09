module Spree
  class PagSeguroController < Spree::BaseController
    protect_from_forgery :except => [:notify]
    
    def notify
      email = Spree::PagSeguro::Config.email
      token = Spree::PagSeguro::Config.token
      notification_code = params[:notificationCode]
      notification = ::PagSeguro::Notification.new(email, token, notification_code)
      
      logger.info "PagSeguro Notification code: #{notification_code}\n\n\n"
      logger.info "PagSeguro Notification inspect:\n#{notification.inspect}"
      
      if notification.approved?
        order = Spree::Order.find(notification.id)
        order.payment.complete
      end
      render nothing: true, head: :ok
    end
    
    def callback
    end
  end
end