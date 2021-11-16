# frozen_string_literal: true

class WorkSpace < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy

  WORK_SPACE_PARAMS = %i[name description].freeze

  scope :by_recently_updated, -> { order(updated_at: :desc) }

  validates :name, presence: true,
                   length: { minimum: Settings.validations.work_space.name.minimum,
                             maximum: Settings.validations.work_space.name.maximum }
end
