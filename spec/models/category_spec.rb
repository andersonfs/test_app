require 'rails_helper'

RSpec.describe Category, type: :model do

  fixtures :categories

  it { expect{ create(:category) }.to change{Category.all.size}.by(1) }

  it 'Create a Category with fixture Comércio' do
    category = categories(:comercio)
    expect(category.description).to eq("Comércio")
  end

  it 'Create a Category with fixture Indústri' do
    category = categories(:industria)
    expect(category.description).to eq("Indústria")
  end

  it 'Create by Factory' do
    category = create(:category)
    expect(category.description).to be_kind_of(String)
  end
end
