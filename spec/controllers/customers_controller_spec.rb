require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end

    it 'responds a 200 response' do
      get :index
      expect(response).to have_http_status(:ok)
    end
end
