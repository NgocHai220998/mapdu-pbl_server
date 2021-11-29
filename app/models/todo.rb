# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :work_space

  TODO_PARAMS = %i[title description priority status].freeze

  scope :by_recently_created, -> { order(created_at: :desc) }

  enum status: Settings.enum.todo.status
  enum priority: Settings.enum.todo.priority

  validates :title, presence: true,
                    length: { minimum: Settings.validations.todo.title.minimum,
                              maximum: Settings.validations.todo.title.maximum }
end
