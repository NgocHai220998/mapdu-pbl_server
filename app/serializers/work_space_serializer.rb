# frozen_string_literal: true

class WorkSpaceSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :description
end
