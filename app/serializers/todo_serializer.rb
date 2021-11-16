# frozen_string_literal: true

class TodoSerializer < ActiveModel::Serializer
  attributes :id, :work_space_id, :title, :description, :priority, :status

  belongs_to :work_space
end
