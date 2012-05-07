module ApplicationHelper
  def money(value, unit)
    number_to_currency(value, precision: 2, unit: unit)
  end
end
