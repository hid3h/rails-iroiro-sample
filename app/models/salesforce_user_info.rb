class SalesforceUserInfo
  attr_reader :given_name

  ENDPOINT = "https://login.salesforce.com/services/oauth2/userinfo"

  class << self
    def retrieve(access_token)
      uri = URI(ENDPOINT)
      conn = Faraday.new
      params = {
        access_token: access_token,
      }
      response = conn.get(uri, params)

      if response.status != 200
        # TODO: エラー
        raise
      end

      parsed_response_body = JSON.parse(response.body)

      new(
        given_name: parsed_response_body["given_name"]
      )
    end
  end

  def initialize(given_name:)
    @given_name = given_name
  end
end
