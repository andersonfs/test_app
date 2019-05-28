class Customer < ApplicationRecord

  def full_name
    "Sr(a). #{name}"
  end
end
