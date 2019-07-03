require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do

    it 'JSON Schema' do
      member = create(:member)
      login_as(member, scope: :member)

      customer = Customer.first
      get "/customers/#{customer.id}.json"
      expect(response).to match_response_schema("customer")
    end

    it "works! 200 OK" do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it "index JSON" do
      get "/customers.json"
      expect(response.body).to include_json([
        id: /\d/,
        name: (be_kind_of String),
        email: (be_kind_of String)
      ])
    end

    it "show JSON" do
      member = create(:member)
      login_as(member, scope: :member)

      customer = Customer.first
      get "/customers/#{customer.id}.json"
      expect(response.body).to include_json(
        id: /\d/, # /\d/ regular expression for digits.
        name: (be_kind_of String),
        email: (be_kind_of String)
      )
    end

    it "show with JSON parse" do
      member = create(:member)
      login_as(member, scope: :member)

      customer = Customer.first
      get "/customers/#{customer.id}.json"
      response_body = JSON.parse(response.body)
      expect(response_body.fetch("id")).not_to be_nil
      expect(response_body.fetch("name")).to be_kind_of(String)
      expect(response_body.fetch("email")).to be_kind_of(String)
    end

    it "create - JSON" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { "ACCEPT" => "application/json" }
      customers_params = attributes_for(:customer)

      post "/customers.json", params: { customer: customers_params }, headers: headers
      expect(response).to have_http_status(:created)
      expect(response.body).to include_json(
        id: /\d/, # /\d/ regular expression for digits.
        name: customers_params.fetch(:name),
        email: customers_params.fetch(:email)
      )
    end

    it "update - JSON" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { "ACCEPT" => "application/json" }
      customer = create(:customer)
      customer.name += " - ATUALIZADO"

      patch "/customers/#{customer.id}.json", params: { customer: customer.attributes }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to include_json(
        id: /\d/, # /\d/ regular expression for digits.
        name: customer.name,
        email: customer.email
      )
    end

    it "delete - JSON" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = { "ACCEPT" => "application/json" }
      customer = Customer.first

      expect{ delete "/customers/#{customer.id}.json", headers: headers }.to change(Customer, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
