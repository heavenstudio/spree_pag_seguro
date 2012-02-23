Spree::Order.class_eval do
  has_many :payment_notifications
  
  def payable_via_pag_seguro?
    !!self.class.pag_seguro_payment_method
  end
  
  def self.pag_seguro_payment_method
    Spree::PaymentMethod.where(type: "Spree::PaymentMethod::PagSeguroMethod").first
  end
end
