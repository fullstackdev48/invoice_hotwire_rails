Rails.application.routes.draw do
  root 'invoices#step1'

  get 'invoices/step1', to: 'invoices#step1', as: :invoices_step1
  post 'invoices/attach_pdf', to: 'invoices#attach_pdf', as: :attach_pdf
  
  post 'invoices/connect_booking', to: 'invoices#connect_booking', as: :connect_booking
  post 'invoices/verify_booking', to: 'invoices#verify_booking', as: :verify_booking
  post 'invoices/add_invoice_details', to: 'invoices#add_invoice_details', as: :add_invoice_details
  post 'invoices/add_line_item', to: 'invoices#add_line_item', as: :add_line_item
  delete 'invoices/:id/remove_line_item', to: 'invoices#remove_line_item', as: :remove_line_item
end
