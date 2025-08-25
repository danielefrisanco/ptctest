class Basket
  def initialize(catalogue:, delivery_charge_rule:, offers:)
    @catalogue = catalogue
    @delivery_charge_rule = delivery_charge_rule
    @offers = offers
    @products = {}
  end

  def add(product_code:)
  end

  def total()
    products_total = @products.sum
    discounted_product_total = @offers.calculate_discount(self)
    final_total = @delivery_charge_rule.find_charge(discounted_product_total)
    final_total
  end
end