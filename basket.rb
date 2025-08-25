class Basket
  def initialize(catalogue:, delivery_charge_rule:, offers:)
    @catalogue = catalogue
    @delivery_charge_rule = delivery_charge_rule
    @offers = offers
    @products = {}
  end

  def add(product_code:)
    # get the product from the catalogue
    product = @catalogue.find_product(product_code)

    @products << product if product
  end

  def total
    products_total = subtotal
    discounted_product_total = products_total - @offers.calculate_discount(self)
    final_total = @delivery_charge_rule.find_charge(discounted_product_total)
    final_total
  end
  private
  def subtotal
    @products.sum(&:price)
  end
end