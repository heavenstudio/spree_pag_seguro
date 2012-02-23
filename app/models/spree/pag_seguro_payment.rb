module Spree
  class PagSeguroPayment < ActiveRecord::Base
    attr_accessor :order_id
    has_one :payment, :as => :source
    
    def process!(payment)
      order = payment.order
      
      redirect_url = Rails.env.development? ? nil : "#{root_url}pag_seguro/callback"

      pag_seguro_payment = ::PagSeguro::Payment.new(
        Order.pag_seguro_payment_method.preferred_email,
        Order.pag_seguro_payment_method.preferred_token,
        redirect_url: redirect_url,
        id: order.id)

      pag_seguro_payment.items = order.line_items.map do |item|
        ::PagSeguro::Item.new(
          id: item.id,
          description: item.product.name,
          amount: format("%.2f", item.price.round(2)),
          quantity: item.quantity,
          weight: ( item.product.weight * 1000 ).to_i
        )
      end

      pag_seguro_payment.sender = ::PagSeguro::Sender.new(name: order.name, email: order.email, phone_number: order.ship_address.phone)
      pag_seguro_payment.shipping = ::PagSeguro::Shipping.new(type: ::PagSeguro::Shipping::SEDEX, state: order.ship_address.state.abbr, city: order.ship_address.city, postal_code: order.ship_address.zipcode, street: order.ship_address.address1, complement: order.ship_address.address2)
      self.code = pag_seguro_payment.code
      self.date = pag_seguro_payment.date
      self.save
    end
  end
end
