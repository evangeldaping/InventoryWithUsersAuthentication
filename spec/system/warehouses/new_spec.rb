require 'rails_helper'

RSpec.describe 'Create a warehouse page', type: :system do
  it 'allows me to create a new warehouse' do
    visit '/warehouses/new'

    within('#warehouse-form') do
      fill_in_warehouse_field('street', with: "Tabora")
      fill_in_warehouse_field('city', with: "Manila")
      fill_in_warehouse_field('province', with: "NCR")
      submit_form
    end

    warehouse = Warehouse.find_by(street: "Tabora", city: "Manila", province: "NCR")

    expect(page).to have_attribute_of('street', value: 'Tabora', record: warehouse)
    expect(page).to have_attribute_of('city', value: 'Manila', record: warehouse)
    expect(page).to have_attribute_of('province', value: 'NCR', record: warehouse)
    expect(page).to have_a_success_message
  end

  it 'shows me test errors' do
    create(:warehouse, street: 'Tabora')

    visit '/warehouses/new'

    submit_form

    expect(page).to show_error_for('street', message: "can't be blank")
    expect(page).to show_error_for('city', message: "can't be blank")
    expect(page).to show_error_for('province', message: "can't be blank")
  end

private

  def fill_in_warehouse_field(name, with:)
    page.find("#warehouse_#{name}").fill_in(with: with)
  end

  def submit_form
    page.find('#submit-button').click
  end

  def have_attribute_of(name, value:, record:)
    have_css("#warehouse--#{record.id}_#{name}", text: value)
  end

  def have_a_success_message
    have_text('Successfully created a warehouse.')
  end

  def show_error_for(name, message:)
    have_css("#warehouse_#{name}_errors .error", text: message)
  end
end
