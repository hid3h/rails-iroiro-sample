class SessionsController < ApplicationController
  # If you're using a strategy that POSTs during callback, you'll need to skip the authenticity token check for the callback action only. 
  skip_before_action :verify_authenticity_token, only: :create

  def create
    p "create", auth_hash
  end

  private

  def auth_hash
    request.env['omniauh.hash']
  end
end
