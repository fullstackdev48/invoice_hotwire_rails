class ChangeBookingIdInInvoicesToNullable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :invoices, :booking_id, true
  end
end
