require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'as a guest' do
    context '#index' do
      it 'responds successfully' do
        get :index
        expect(response).to be_success
      end

      it 'responds a 200 response' do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    it 'responds show as 302 (not authorized)' do
      create(:customer)
      get :show, params: { id: Customer.first.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'as a Logged Member' do
    let(:member) { create(:member) }
    before do
      create(:customer)
      sign_in member
    end

    it 'responds show as 200 after authorization' do
      get :show, params: { id: Customer.first.id}
      expect(response).to have_http_status(:ok)
    end

    it 'render a :show template' do
      get :show, params: { id: Customer.first.id}
      expect(response).to render_template(:show)
    end
  end
end
