module Spree
  class PaymentMethod::PagSeguroMethod < PaymentMethod
    attr_accessor :order_id
    
    preference :email, :string
    preference :token, :string
    has_many :payments, :as => :source
    
    def actions
      %w{capture void}
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      ['checkout', 'pending'].include?(payment.state)
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end

    def capture(*args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def void(*args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end
    
    def payment_source_class
      self.class
    end

    def source_required?
      false
    end
    
    def code(payment)
      if payment.pag_seguro_payment.present?
        payment.pag_seguro_payment.code
      else
        pag_seguro_payment = Spree::PagSeguroPayment.new
        pag_seguro_payment.process!(payment)
        pag_seguro_payment.code
      end
    end
  end
end
