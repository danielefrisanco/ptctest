# spec/basket_spec.rb
require 'spec_helper'

RSpec.describe Basket do
  let(:catalogue) do
    products_data = [
      { code: 'R01', name: 'Red Widget', price: 32.95 },
      { code: 'G01', name: 'Green Widget', price: 24.95 },
      { code: 'B01', name: 'Blue Widget', price: 7.95 }
    ]
    Catalogue.new(products_data)
  end

  let(:delivery_charge_rule) do
    delivery_charge_rule_data = [
      { upper_limit: 90.00, cost: 0.00 },
      { upper_limit: 50.00, cost: 2.95 },
      { upper_limit: 0.00, cost: 4.95 }
    ]
    DeliveryChargeRule.new(delivery_charge_rule_data)
  end

  let(:offers) do
    [BuyOneGetAnotherHalfPrice.new(product_code: 'R01')]
  end

  context 'total bigger less than 50' do
    it 'calculates the correct total for basket' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('B01')
      basket.add('G01')
      expect(basket.total).to eq(37.85)
    end
  end
  context 'total bigger than 50 and less than 90' do
    it 'calculates the correct total for basket without possible offers' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('R01')
      basket.add('G01')
      expect(basket.total).to eq(60.85)
    end
    it 'calculates the correct total for basket with possible offers' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('R01')
      basket.add('R01')
      basket.add('R01')
      expect(basket.total).to eq(85.32)
    end
  end
  context 'total bigger than 90' do
    it 'calculates the correct total for basket' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('R01')
      basket.add('R01')
      basket.add('R01')
      basket.add('R01')
      basket.add('G01')
      basket.add('B01')
      expect(basket.total).to eq(131.75)
    end
  end

  context 'can add products and the total is recalculated' do
    it 'calculates the correct totals for basket after adding new products' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('R01')
      expect(basket.total).to eq(37.9)
      basket.add('G01')
      expect(basket.total).to eq(60.85)
      basket.add('B01')
      expect(basket.total).to eq(68.8)
      basket.add('R01')
      expect(basket.total).to eq(85.27)
    end
  end
  context 'can different set of rules give different results' do
    let(:delivery_charge_rule_2) do
      delivery_charge_rule_data = [
        { upper_limit: 50.00, cost: 0.00 },
        { upper_limit: 20.00, cost: 2 },
        { upper_limit: 0.00, cost: 6 }
      ]
      DeliveryChargeRule.new(delivery_charge_rule_data)
    end
    let(:offers_2) do
      [BuyOneGetAnotherHalfPrice.new(product_code: 'B01')]
    end
    it 'calculates the correct totals for the baskets following different rules' do
      basket1 = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket2 = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers_2)
      basket1.add('R01')
      basket1.add('R01')
      basket1.add('B01')
      basket1.add('B01')
      basket2.add('R01')
      basket2.add('R01')
      basket2.add('B01')
      basket2.add('B01')
      expect(basket1.total).to eq(68.27)
      expect(basket2.total).to eq(80.77)
    end
  end
  context 'example tests' do
    it 'calculates the correct total for basket 1' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('B01')
      basket.add('G01')
      expect(basket.total).to eq(37.85)
    end
    it 'calculates the correct total for basket 2' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('R01')
      basket.add('R01')
      expect(basket.total).to eq(54.37)
    end
    it 'calculates the correct total for basket 3' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('R01')
      basket.add('G01')
      expect(basket.total).to eq(60.85)
    end
    it 'calculates the correct total for basket 4' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: offers)
      basket.add('B01')
      basket.add('B01')
      basket.add('R01')
      basket.add('R01')
      basket.add('R01')
      expect(basket.total).to eq(98.27)
    end
  end
  context 'no offers' do
    let(:no_offers) do
      []
    end
    it 'calculates the correct total for basket' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: delivery_charge_rule, offers: no_offers)
      basket.add('R01')
      basket.add('R01')
      expect(basket.total).to eq(68.85)
    end
  end

  context 'no delivery charges' do
    let(:no_delivery_charge_rule) do
      DeliveryChargeRule.new([])
    end
    it 'calculates the correct total for basket' do
      basket = described_class.new(catalogue: catalogue, delivery_charge_rule: no_delivery_charge_rule, offers: offers)
      basket.add('R01')
      basket.add('R01')
      expect(basket.total).to eq(49.42)
    end
  end
end