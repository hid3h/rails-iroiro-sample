class SessionsController < ApplicationController
  # If you're using a strategy that POSTs during callback, you'll need to skip the authenticity token check for the callback action only. 
  skip_before_action :verify_authenticity_token, only: :create

  def create
    p "auth_hash", auth_hash
    p "info", auth_hash.info
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
