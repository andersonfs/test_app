require 'rails_helper'

RSpec.describe Member, type: :model do
  it { expect{ create(:member) }.to change{Member.all.size}.by(1) }
end
