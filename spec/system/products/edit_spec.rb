require 'rails_helper'

RSpec.describe 'Edit product page', type: :system do
  include AuthHelper
  it 'allows to edit a product' do
    product = create(:product, name: "Haier", sku: "HTV-32-LED")

    sign_in_as_user
    visit "/products/#{product.id}/edit"


    expect(page).to have_value_of("Haier", attr: 'name')
    expect(page).to have_value_of("HTV-32-LED", attr: 'sku')

    #
    fill_in_product_field('name', with: 'Sony')
    fill_in_product_field('sku', with: 'SNY-65-LED')
    submit_form

    #
    expect(page).to have_attribute_of('name', value: 'Sony', record: product)
    expect(page).to have_attribute_of('sku', value: 'SNY-65-LED', record: product)
    expect(page).to have_a_success_message
  end

  it 'shows me test errors' do
    create(:product, sku: 'PROD-001')
    product = create(:product)

    sign_in_as_user
    visit "/products/#{product.id}/edit"
    fill_in_product_field('name', with: '')
    fill_in_product_field('sku', with: '')
    submit_form

    expect(page).to show_error_for('name', message: "can't be blank")
    expect(page).to show_error_for('sku', message: "can't be blank")

    within('#product-form') do
      fill_in_product_field('sku', with: 'PROD-001')
      submit_form
    end

    expect(page).to show_error_for('sku', message: "has already been taken")
  end

  private

  def have_value_of(value, attr:)
    have_field("product_#{attr}", with: value)
  end

  def fill_in_product_field(name, with:)
    page.find("#product_#{name}").fill_in(with: with)
  end

  def submit_form
    page.find('#submit-button').click
  end

  def have_attribute_of(name, value:, record:)
    have_css("#product--#{record.id}_#{name}", text: value)
  end

  def have_a_success_message
    have_text('Successfully updated product.')
  end

  def show_error_for(name, message:)
    have_css("#product_#{name}_errors .error", text: message)
  end
end
