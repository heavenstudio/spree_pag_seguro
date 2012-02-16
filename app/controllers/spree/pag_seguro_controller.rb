module Spree
  class PagSeguroController < BaseController
    protect_from_forgery :except => [:notify]
    
    def notify
      notification = Spree::PaymentNotification.create_from_params(params)
      
      if notification.approved?
        Order.transaction do
          order = Spree::Order.find(notification.id)
          
          #create payment for this order
          payment = Spree::Payment.new
          
          # 1. Assume that if payment notification comes, it's exactly for the amount
          # sent to pagseguro (safe assumption -- cart can't be edited while on pagseguro)
          # 2. Can't use Order#total, as it's intercepted by spree-multi-currency
          # which might lead to lots of false "credit owed" payment states
          # (when they should be "complete")
          payment.amount = order.read_attribute(:total)
          
          payment.payment_method = Spree::Order.pag_seguro_payment_method
          order.payments << payment
          payment.started_processing
          
          order.payment.complete
          
          until @order.state == "complete"
            if @order.next!
              @order.update!
              state_callback(:after)
            end
          end
        end
      end
      
      render nothing: true, head: :ok
    end
    
    def callback
    end
    
    protected
      # those methods are copy-pasted from CheckoutController
      # we cannot inherit from that class unless we want to skip_before_filter
      # half of calls in SpreeBase module
      def state_callback(before_or_after = :before)
        method_name = :"#{before_or_after}_#{@order.state}"
        send(method_name) if respond_to?(method_name, true)
      end
    
      def before_address
        @order.bill_address ||= Address.new
        @order.ship_address ||= Address.new
      end
    
      def before_delivery
        @order.shipping_method ||= (@order.rate_hash.first && @order.rate_hash.first[:shipping_method])
      end
    
      def before_payment
        current_order.payments.destroy_all if request.put?
      end
    
  		#This isn't working here in payment_nofitications_controller since IPN will run on a different session
      def after_complete
        session[:order_id] = nil
      end    
  end
end