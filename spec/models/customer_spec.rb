require 'rails_helper'

RSpec.describe Customer, type: :model do

  fixtures :customers

  it 'Create a Customer with fixtures' do
    customer = customers(:anderson)
    expect(customer.full_name).to eq("Sr(a). Anderson Firmino da Silva")
  end

  it '#full_name' do
    customer = create(:customer)
    customer1 = create(:customer)
    puts customer.email
    puts customer1.email
    expect(customer.full_name).to start_with("Sr(a). ")
  end

  it '#full_name with specific name' do
    customer = create(:customer, name: 'Anderson Firmino')
    expect(customer.full_name).to start_with("Sr(a). Anderson Firmino")
  end

  it '#full_name with alias' do
    customer = create(:user, name: 'Anderson Firmino')
    expect(customer.full_name).to start_with("Sr(a). Anderson Firmino")
  end

  it '#heranca customer vip' do
    customer = create(:customer_vip)
    expect(customer.vip).to eq(true)
  end

  it '#heranca customer default' do
    customer = create(:customer_default)
    expect(customer.vip).to eq(false)
  end

  it '#Usando o attributes for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with("Sr(a). ")
  end

  it '#Atributo transitório' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it '#Cliente masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be_falsey
  end

  it '#Cliente masculino e vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be_truthy
  end

  it '#Cliente feminino' do
    customer = create(:customer_female)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_falsey
  end

  it '#Cliente feminino e vip' do
    customer = create(:customer_female_vip)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_truthy
  end

  it 'travel_to' do
    travel_to Time.zone.local(2004, 11, 24, 01, 04, 44) do
      @customer = create(:customer_vip)
    end

    expect(@customer.created_at).to eq(Time.new(2004, 11, 24, 01, 04, 44))
    expect(@customer.created_at).to be < Time.zone.now
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end
