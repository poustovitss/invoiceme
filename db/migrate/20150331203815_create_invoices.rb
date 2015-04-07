class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :invoice_number, null: false
      t.datetime :invoice_date, null: false
      t.integer :user_id,       null: false
      t.string :currency,       null: false
      t.text   :comment,        null: false, default: ''

      t.timestamps
    end

    add_index :invoices, :invoice_number
  end
end
