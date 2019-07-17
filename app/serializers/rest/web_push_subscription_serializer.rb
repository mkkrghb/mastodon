# frozen_string_literal: true

class REST::WebPushSubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :endpoint, :alerts, :server_key

  def alerts
    (object.data&.dig('alerts') || {}).reduce({}) { |hash, (k, v)| hash[k] = ActiveModel::Type::Boolean.new.cast(v); hash }
  end

  def server_key
    Rails.configuration.x.vapid_public_key
  end
end
