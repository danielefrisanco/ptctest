class Basket
  def initialize(catalogue:, delivery_charge_rule:, offers:)
    @catalogue = catalogue
    @delivery_charge_rule = delivery_charge_rule
    @offers = offers
    @products = []
  end

  def add(product_code)
    # get the product from the catalogue
    product = @catalogue.find_product(product_code)

    @products << product if product
  end

  def total
    discounted_product_total = subtotal - offers_discount
    delivery_charge = @delivery_charge_rule.find_charge(discounted_product_total)
    final_total = discounted_product_total + delivery_charge
    final_total.truncate(2)
  end

  private

  def subtotal
    @products.sum(&:price)
  end

  def offers_discount
    available_products = @products.dup

    @offers.map do |offer|
      result = offer.apply(available_products)
      # Remove the products that were used in the offer
      available_products -= result[:products_used]
      result[:discount]
    end.sum
  end
end