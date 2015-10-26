class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :userkey, :email, :killin_its_given, :killin_its_received, :created_at, :updated_at

  def killin_its_given
      object.killin_its_from.count
  end

  def killin_its_received
      object.killin_its_to.count
  end
end
