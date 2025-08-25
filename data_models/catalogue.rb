class Catalogue
  def initialize(products)
    @products = products.map do |product_data|
      Product.new(**product_data)
    end.to_h { |product| [product.code, product] }
  end

  def find_product(code)
    @products[code]
  end
end