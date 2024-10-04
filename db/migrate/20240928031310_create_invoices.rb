class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
