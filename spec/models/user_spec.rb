require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it "is valid with valid attributes" do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

    it "is not valid without a email" do
      user = FactoryBot.create(:user)
      user.email = "is.string" # Not a email
      expect(user).to_not be_valid
    end

    it "has many work_spaces" do
      association = described_class.reflect_on_association(:work_spaces)
      expect(association.macro).to eq :has_many
    end
  end
end
