require 'rails_helper'

RSpec.describe 'Index of all Stocks page', type: :system do
  it 'has a table of stocks', :js do
    create_list(:stock, 4)
    stock = create(count: 2, product_id: 3, warehouse_id: 4)

    visit '/stocks'

    expect(page).to have_a_stocks_table
    # expect(page).to have_a_new_stocks_table
    expect(page).to have_stocks_with(count: 5)
    expect(page).to have_table_header_with(text: 'Count')
    expect(page).to have_table_header_with(text: 'Product ID')
    expect(page).to have_table_header_with(text: 'Warehouse ID')
    expect(page).to have_table_header_with(text: 'Updated At')
    expect(page).to have_column_for('count', value: '2', record: stock)
    expect(page).to have_column_for('product_id', value: '3', record: stock)
    expect(page).to have_column_for('warehouse_id', value: '4', record: stock)
end

private

  def have_a_stocks_table
    have_css('table#stocks-table')
  end

  def have_stocks_with(count:)
    have_css('table tbody tr', count: count)
  end

  def have_table_header_with(text:)
    have_css('table thead tr th', text: text)
  end

  def have_column_for(text, value:, record:)
    have_css("table tbody tr#stock--#{record.id} td#stock--#{record.id}_#{name}", text: value)
  end
end
