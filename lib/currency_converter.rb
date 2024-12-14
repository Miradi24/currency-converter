require "money"

module CurrencyConverter
  def get_currencies
    Money::Currency.all()
  end
end
