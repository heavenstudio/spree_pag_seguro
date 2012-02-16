class CreateSpreePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :spree_payment_notifications do |t|
      t.text :params
      t.string :status
      t.string :transaction_id
      t.integer :order_id
      t.string :notification_code
      t.timestamps
    end
  end
end