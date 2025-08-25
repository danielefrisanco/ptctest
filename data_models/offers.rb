class Offers
  # def initialize(product_code, discounted_product_code, discount_percent)
  #   @product_code = product_code
  #   @discounted_product_code = discounted_product_code
  #   @discount_percent = discount_percent
  # end
  def initialize(offers)
    @offers = offers
  end

  def calculate_discount(basket)
  end
end