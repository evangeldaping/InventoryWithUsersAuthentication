require 'rails_helper'

RSpec.describe 'Shows the Warehouse page', type: :system do
  include AuthHelper
  it 'shows all warehouse information', :js do
    warehouse = create(:warehouse, street: 'Tabora', city: 'Manila', province:
    'NCR')

    sign_in_as_user
    visit "/warehouses/#{warehouse.id}"

    expect(page).to have_attribute_for('street', value: 'Tabora', record: warehouse)
    expect(page).to have_attribute_for('city', value: 'Manila', record: warehouse)
    expect(page).to have_attribute_for('province', value: 'NCR', record: warehouse)
  end

  # it 'allows to go back to index page', type: :system do
  #   warehouse = create(:warehouse, street: 'Tabora', city: 'Manila', province:
  #   'NCR')
  #   visit "/warehouses/#{warehouse.id}"

    # page.click_button('btn btn-primary')

    # expect(page).to visit "/warehouses"
  # end

  private

  def have_attribute_for(name, value:, record:)
    have_css("#warehouse--#{record.id}_#{name}", text: value)
  end
end
