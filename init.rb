require_relative 'data_models/catalogue'
require_relative 'data_models/delivery_charge_rule'
require_relative 'offers/buy_one_get_another_half_price'
require_relative 'basket'

PRODUCTS_DATA = [
  { code: 'R01', name: 'Red Widget', price: 32.95 },
  { code: 'G01', name: 'Green Widget', price: 24.95 },
  { code: 'B01', name: 'Blue Widget', price: 7.95 }
].freeze
catalogue = Catalogue.new(PRODUCTS_DATA)

DELIVERY_CHARGE_RULE_DATA = [
  { upper_limit: 0.00, cost: 4.95 },
  { upper_limit: 50.00, cost: 2.95 },
  { upper_limit: 90.00, cost: 0.00 }
].freeze

delivery_charge_rule = DeliveryChargeRule.new(DELIVERY_CHARGE_RULE_DATA)

OFFERS = [
  BuyOneGetAnotherHalfPrice.new(product_code: 'R01')
]

basket = Basket.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: OFFERS)

basket.add('R01')
puts "$#{basket.total}"
