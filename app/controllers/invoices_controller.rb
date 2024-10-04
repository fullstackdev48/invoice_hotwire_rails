class InvoicesController < ApplicationController
  def step1
    @invoice = Invoice.new
  end

  def attach_pdf
    @invoice = Invoice.new(invoice_params)
    @invoice.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('step1_frame', partial: 'invoices/step2', locals: { invoice: @invoice }),
          turbo_stream.update('step_nav', partial: 'invoices/step_nav', locals: { current_step: 2 })
        ]
      end
    end
  end

  def connect_booking
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.update(booking_item: params[:booking_item])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('step2_frame', partial: 'invoices/step3', locals: { invoice: @invoice }),
          turbo_stream.update('step_nav', partial: 'invoices/step_nav', locals: { current_step: 3 })
        ]
      end
    end
  end

  def verify_booking
    @invoice = Invoice.find(params[:invoice_id])

    @invoice.update(germany_residence: params[:germany_residence] == "0" ? false : true)
    @line_item = @invoice.line_items.build
    @line_item.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('step3_frame', partial: 'invoices/step4', locals: { invoice: @invoice }),
          turbo_stream.update('step_nav', partial: 'invoices/step_nav', locals: { current_step: 4 })
        ]
      end
    end
  end

  def add_invoice_details
    @invoice = Invoice.find(params[:invoice_id])
    
    @invoice.update(invoice_params)
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('step4_frame', partial: 'invoices/step5', locals: { invoice: @invoice }),
          turbo_stream.update('step_nav', partial: 'invoices/step_nav', locals: { current_step: 5 })
        ]
      end
    end
  end

  def add_line_item
    @invoice = Invoice.find(params[:invoice_id])
    @line_item = @invoice.line_items.build
    @line_item.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: 
          turbo_stream.append("line_item_list", partial: "line_items/line_item", locals: { line_item: @line_item })
      end
    end
  end
    
  def remove_line_item
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: 
          turbo_stream.remove("line_item_#{@line_item.id}")
      end
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :pdf,
      :country,
      :vat_number,
      :company_name,
      :invoice_date,
      :invoice_number,
      :street_name,
      :street_number,
      :postal_code,
      :city,
      :has_word,
      line_items_attributes: [:id, :traveler_name, :start_date, :end_date, :description, :category, :quantity, :unit, :price, :vat_rate]
    )
  end
end
