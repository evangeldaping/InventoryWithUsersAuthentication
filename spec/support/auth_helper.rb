require 'rails_helper'

module AuthHelper
  def sign_in_as_user
    sign_in create(:user)
  end
end
