class CreateLineItems < ActiveRecord::Migration[7.2]
  def change
    create_table :line_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.timestamps
    end
  end
end
