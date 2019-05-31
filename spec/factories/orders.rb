FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número - #{n}" }
    customer
    # association :customer, factory: :customer => Para sobrescrever uma fábrica    
    # association :customer, factory: :customer_male
    #association :customer, factory: :customer_female
  end
end
