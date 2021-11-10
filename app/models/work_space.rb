class WorkSpace < ApplicationRecord
  belongs_to :user

  WORK_SPACE_PARAMS = %i(name description).freeze

  validates :name, presence: true,
  length: {minimum: Settings.validations.work_space.name.minimum,
            maximum: Settings.validations.work_space.name.maximum}
end
