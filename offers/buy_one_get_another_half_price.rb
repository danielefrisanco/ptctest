class BuyOneGetAnotherHalfPrice
  def initialize(product_code:)
    @product_code = product_code
  end

  def apply(products)
    discount = 0.0
    products_discounted = []
    # Get the products that can be discounted
    discountable_products = products.select { |item| item.code == @product_code }
    num_discounted_products = discountable_products.count / 2

    if num_discounted_products > 0
      product_price = discountable_products.first.price
      discount = (product_price / 2) * num_discounted_products
      # one product could be left out
      products_discounted = discountable_products.take(num_discounted_products * 2)
    end
    
    { discount: discount, items_used: products_discounted }
  end
end