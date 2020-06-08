class CreateSpreeRobokassaCheckouts < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_robokassa_checkouts do |t|
      t.string :token
      t.string :payer_id
      t.string :transaction_id, index: true
      t.string :state, default: 'complete'
      t.datetime :created_at
    end
  end
end
