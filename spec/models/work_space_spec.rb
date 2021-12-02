require 'rails_helper'

RSpec.describe WorkSpace, type: :model do
  user = FactoryBot.create(:user)

  describe User do
    it "is valid with valid attributes" do
      work_space = FactoryBot.create(:work_space, user_id: user.id)
      expect(work_space).to be_valid
    end

    it "is not valid without a string" do
      work_space = FactoryBot.create(:work_space, user_id: user.id)
      work_space.name = nil
      expect(work_space).to_not be_valid
    end

    it "is not valid user" do
      work_space = FactoryBot.create(:work_space, user_id: user.id)
      work_space.user_id = nil
      expect(work_space).to_not be_valid
    end

    it "has many todos" do
      association = WorkSpace.reflect_on_association(:todos)
      expect(association.macro).to eq :has_many
    end

    it "belongs to user" do
      association = WorkSpace.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end
end
