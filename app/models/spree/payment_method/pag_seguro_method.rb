module Spree
  class PaymentMethod::PagSeguroMethod < PaymentMethod
    preference :email, :string
    preference :token, :string
    
    def payment_source_class
      PagSeguroPayment
    end
  end
end
