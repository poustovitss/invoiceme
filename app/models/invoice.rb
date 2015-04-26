# == Schema Information
#
# Table name: invoices
#
#  id               :integer          not null, primary key
#  invoice_number   :string(255)      not null
#  invoice_date     :datetime         not null
#  user_id          :integer          not null
#  currency         :string(255)      not null
#  comment          :text             default(""), not null
#  company_id       :integer          not null
#  client_id        :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  company_row_text :text             not null
#  client_row_text  :text             not null
#  subtotal         :float            not null
#  vat_rate         :float
#  vat              :float
#  discount         :float
#  status           :string(255)      default("open"), not null
#

class Invoice < ActiveRecord::Base
  # include StateMachines::InvoiceMachine
  include InvoiceMachine
  CURRENCY = %w(EUR USD UAH RUB)
  STATE = state_machines[:state].states.map(&:name)

  ## Relations
  belongs_to :company
  belongs_to :client
  belongs_to :user
  has_many :invoice_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :journals, dependent: :destroy

  ## Nested forms
  accepts_nested_attributes_for :invoice_items

  ## Validations
  # Iterates through constants, and dynamically creates validations
  [:CURRENCY, :STATE].each do |param|
    # rubocop:disable all
    inclusion = eval param.to_s
    # rubocop:enable all
    message = "is not included in the list #{inclusion.join(',')}"
    validates param.downcase, inclusion: { in: inclusion, message: message }
  end

  validates :invoice_number, :invoice_date, presence: true
  validates :user_id, :company_id, :client_id, presence: true
  validates :company_row_text, :client_row_text, length: { in: 1..300 }
  validates :subtotal, presence: true, numericality: true
  validates :vat_rate, :vat, :discount, numericality: true, allow_blank: true

  ## Instance methods
  def amount
    invoice_items.map(&:sum).reduce(:+)
  end

  def close!
    update_attribute(:state, 'closed')
  end

  def overdue!
    update_attribute(:state, 'overdue')
  end
end
