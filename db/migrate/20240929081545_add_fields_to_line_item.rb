class AddFieldsToLineItem < ActiveRecord::Migration[7.2]
  def change
    add_column :line_items, :traveler_name, :string
    add_column :line_items, :start_date, :date
    add_column :line_items, :end_date, :date
    add_column :line_items, :description, :string
    add_column :line_items, :category, :string
    add_column :line_items, :quantity, :integer
    add_column :line_items, :unit, :string
    add_column :line_items, :price, :decimal, precision: 10, scale: 2
    add_column :line_items, :vat_rate, :string
  end
end
