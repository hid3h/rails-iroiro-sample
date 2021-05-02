Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth/strategies/line' # なかったらエラー出た
  provider :line, ENV['channel_id'], ENV['channel_secret']
  # provider :twitter, Rails.application.credentials.twitter[:api_key], Rails.application.credentials.twitter[:api_secret]
end
