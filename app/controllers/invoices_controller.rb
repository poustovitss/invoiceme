class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @invoices = current_user.invoices.all
    respond_with(@invoices)
  end

  def show
    respond_with(@invoice)
  end

  def new
    @invoice = current_user.invoices.new
    respond_with(@invoice)
  end

  def edit
  end

  def create
    @invoice = current_user.invoices.new(invoice_params)
    @invoice.save
    respond_with(@invoice)
  end

  def update
    @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private
    def set_invoice
      @invoice = current_user.invoices.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit([
        :invoice_number,
        :invoice_date,
        :currency,
        :comment,
        :invoice_items
      ])
    end
end
