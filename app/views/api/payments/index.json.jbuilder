json.payments do 
  json.array!(@payments) do |payment|
    json.extract! payment, :id, :invoice_id, :amount
    json.invoice payment.invoice
    json.client payment.client
    json.company payment.company
  end
end