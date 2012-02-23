module Spree
  class PagSeguroController < BaseController
    protect_from_forgery :except => [:notify]
    skip_before_filter :restriction_access
    
    def notify
      notification = Spree::PaymentNotification.create_from_params(params)
      
      if notification.approved?
        Order.transaction do
          @order = Spree::Order.find(notification.id)
          
          # 1. Assume that if payment notification comes, it's exactly for the amount
          # sent to pagseguro (safe assumption -- cart can't be edited while on pagseguro)
          # 2. Can't use Order#total, as it's intercepted by spree-multi-currency
          # which might lead to lots of false "credit owed" payment states
          # (when they should be "complete")
          @order.payment.complete
        end
      end
      
      render nothing: true, head: :ok
    end
    
    def callback
    end
    
  end
end