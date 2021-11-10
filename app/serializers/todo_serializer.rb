class TodoSerializer < ActiveModel::Serializer
  attributes :id, :work_space_id, :title, :description, :priority, :status
end
