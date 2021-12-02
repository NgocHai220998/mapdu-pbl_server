require 'rails_helper'

RSpec.describe WorkSpace, type: :model do
  user = FactoryBot.create(:user)
  work_space = FactoryBot.create(:work_space, user_id: user.id)
  todo = FactoryBot.create(:todo, work_space_id: work_space.id)

  describe User do
    it "todo is valid with valid attributes" do
      expect(todo).to be_valid
    end

    it "title is not valid without a string" do
      todo.title = nil
      expect(todo).to_not be_valid
    end

    it "is not valid work_space" do
      todo.work_space_id = nil
      expect(todo).to_not be_valid
    end

    it "belongs to work space" do
      association = Todo.reflect_on_association(:work_space)
      expect(association.macro).to eq :belongs_to
    end
  end
end
