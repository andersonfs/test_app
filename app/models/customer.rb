class Customer < ApplicationRecord
  has_many :orders

  def full_name
    "Sr(a). #{name}"
  end
end
