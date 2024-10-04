class AddFieldsToInvoices < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :booking_item, :string
    add_column :invoices, :germany_residence, :boolean, default: true
    add_column :invoices, :country, :string
    add_column :invoices, :vat_number, :string
    add_column :invoices, :company_name, :string
    add_column :invoices, :invoice_date, :date
    add_column :invoices, :invoice_number, :string
    add_column :invoices, :street_name, :string
    add_column :invoices, :street_number, :string
    add_column :invoices, :postal_code, :string
    add_column :invoices, :city, :string
    add_column :invoices, :has_word, :boolean, default: false
  end
end
