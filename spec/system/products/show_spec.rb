require 'rails_helper'

RSpec.describe 'Shows the Product page', type: :system do
  include AuthHelper
  it 'shows all product information', :js do
    product = create(:product, sku: 'CAS-012', name: 'Casio Watch')

    sign_in_as_user
    visit "/products/#{product.id}"

    expect(page).to have_attribute_for('sku', value: 'CAS-012', record: product)
    expect(page).to have_attribute_for('name', value: 'Casio Watch', record: product)
  end

  private

  def have_attribute_for(name, value:, record:)
    have_css("#product--#{record.id}_#{name}", text: value)
  end
end
