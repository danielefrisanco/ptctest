PRODUCTS_DATA = [
  { code: 'R01', name: 'Red Widget', price: 32.95 },
  { code: 'G01', name: 'Green Widget', price: 24.95 },
  { code: 'B01', name: 'Blue Widget', price: 7.95 }
].freeze
catalogue = Catalogue.new(PRODUCTS_DATA)

DELIVERY_CHARGE_RULE_DATA = [
  { threshold: 0.00, cost: 4.95 },
  { threshold: 50.00, cost: 2.95 },
  { threshold: 90.00, cost: 0.00 }
].freeze

delivery_charge_rules = DeliveryChargeRule.new(DELIVERY_CHARGE_RULE_DATA)