class WorkSpaceSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :description
end
