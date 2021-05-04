Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth/strategies/line' # なかったらエラー出た
  # 開発中'omniauth/strategies/line' の変更が反映されない。
  # ここで読み込んでるからかな
  provider :line, ENV['channel_id'], ENV['channel_secret']

  provider :twitter, ENV['api_key'], ENV['api_secret']
end
