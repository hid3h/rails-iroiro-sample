class Auth::SalesforceController < ApplicationController
  def create
    oauth_authorize_url = SalesforceOauth.oauth_authorize_url
    redirect_to(oauth_authorize_url)
  end

  def callback
    code = params[:code]
    salesforce_oauth = SalesforceOauth.retrieve_access_token(code)

    salesforce_user_info = SalesforceUserInfo.retrieve(salesforce_oauth.access_token)
    given_name = salesforce_user_info.given_name

    render plain: "given_name: #{given_name}"
  end
end
