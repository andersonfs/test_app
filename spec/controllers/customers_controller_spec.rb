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

    it 'with valid attributes' do
      customer_params = attributes_for(:customer)

      expect{
         post :create, params: { customer: customer_params }
      }.to change(Customer, :count).by(1)
    end

    it 'flash notice' do
      customer_params = attributes_for(:customer)
      post :create, params: { customer: customer_params }
      expect(flash[:notice]).to match(/successfully created/)
    end

    it 'Content-Type JSON on Show' do
      get :show, format: :json, params: { id: Customer.first.id }
      expect(response.content_type).to eq('application/json')
    end

    it 'Content-Type JSON on Create' do
      customer_params = attributes_for(:customer)
      post :create, format: :json, params: { customer: customer_params }
      expect(response.content_type).to eq('application/json')
    end
  end
end
