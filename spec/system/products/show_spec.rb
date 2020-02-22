require 'rails_helper'

RSpec.describe 'Shows the Product page', type: :system do
  it 'shows all product information', :js do
    product = create(:product, sku: 'CAS-012', name: 'Casio Watch')

    visit "/products/#{product.id}"

    expect(page).to have_attribute_for('sku', value: 'CAS-012', record: product)
    expect(page).to have_attribute_for('name', value: 'Casio Watch', record: product)
  end

  private

  def have_attribute_for(name, value:, record:)
    have_css("#product--#{record.id}_#{name}", text: value)
  end
end
