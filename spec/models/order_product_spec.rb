# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderProduct do
  subject { described_class.new }

  it 'has a valid factory' do
    expect(build(:order_product)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }

    # TODO: This line can be removed once 'attr_readonly :each_item_price_in_cents' added to OrderProduct
    it { is_expected.to validate_presence_of(:each_item_price_in_cents) }
  end

  describe 'subtotal' do
    let!(:product) { create(:product, price_in_cents: 100) }
    let!(:order_product) { create(:order_product, quantity: 2, product:) }

    it 'returns the subtotal' do
      order_product.update!(each_item_price_in_cents: 100)
      expect(order_product.subtotal).to eq(200)
    end

    context 'with product price changing' do
      it 'keeps the current order price' do
        expect { product.update!(price_in_cents: 200) }.not_to(change { order_product.reload.subtotal })
      end
    end
  end

  describe 'before create' do
    let!(:order_product) { create(:order_product, quantity: 1) }

    it 'grabs the item price from product' do
      expect(order_product.each_item_price_in_cents).to eql(order_product.product.price_in_cents)
    end
  end

  describe 'ransackable_attributes' do
    it 'returns an array with the attributes' do
      expect(described_class.ransackable_attributes).to eq(%w[created_at id id_value order_id product_id
                                                              quantity
                                                              each_item_price_in_cents
                                                              updated_at])
    end
  end

  describe 'ransackable_associations' do
    it 'returns an empty array' do
      expect(described_class.ransackable_associations).to eq(%w[order product])
    end
  end
end
