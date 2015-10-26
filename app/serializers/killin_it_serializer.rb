class KillinItSerializer < ActiveModel::Serializer
  attributes :id, :message, :created_at, :updated_at
  has_one :from_user
  has_one :to_user
end
