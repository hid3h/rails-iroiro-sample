class Auth::SalesforceController < ApplicationController
  def create
    uri = URI("https://login.salesforce.com/services/oauth2/authorize")

    # salesforce側でコールバックURLに127.0.0.1が使えないのでlocalhostを使っている
    redirect_uri = "http://localhost#{callback_auth_salesforce_path}"
    uri.query = {
      response_type: "code",
      client_id: ENV["SALESFORCE_CLIENT_ID"],
      redirect_uri: redirect_uri
    }.to_param
    redirect_to(uri.to_s)
  end

  def callback
    code = params[:code]
    salesforce_oauth = SalesforceOauth.retrieve_access_token(code)
  end
end
