require 'rails_helper'

RSpec.describe 'Homepage page', type: :system do
  it 'displays a calculator', :js do
    visit root_path

    expect(page).to have_a_calculator
  end

  it 'changes the header text', :js do
    visit root_path

    expect(page).to have_header_text('Hello World')

    change_text('#header_text_input', with: 'Bye world. :(')

    expect(page).to have_header_text('Bye world. :(')
  end

  private

  def have_a_calculator
    have_css('#calc')
  end

  def change_text(id, with:)
    page.find(id).fill_in(with: with)
  end

  def have_header_text(val)
    have_text(val)
  end
end
