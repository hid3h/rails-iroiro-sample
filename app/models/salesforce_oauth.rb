class SalesforceOauth
  attr_reader :access_token

  ACCESS_TOKEN_REQUEST_ENDPONT = "https://login.salesforce.com/services/oauth2/token"

  class << self
    def retrieve_access_token(code)
      uri = URI(ACCESS_TOKEN_REQUEST_ENDPONT)
      conn = Faraday.new(
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded",
        },
      )
      params = {
        grant_type: "authorization_code",
        client_id: client_id,
        client_secret: client_secret,
        redirect_uri: redirect_uri,
        code: code,
      }

      response = conn.post(uri) do |req|
        req.body = params.to_query
      end

      if response.status != 200
        # TODO: エラー処理
        Rails.logger.error(response.body)
        raise response.body
      end

      parsed_response_body = JSON.parse(response.body)

      new(parsed_response_body["access_token"])
    end

    def client_id
      ENV["SALESFORCE_CLIENT_ID"]
    end

    def client_secret
      ENV["SALESFORCE_CLIENT_SECRET"]
    end

    def redirect_uri
      # salesforce側でコールバックURLに127.0.0.1が使えないのでlocalhostを使っている
      "http://localhost#{Rails.application.routes.url_helpers.callback_auth_salesforce_path}"
    end
  end

  def initialize(access_token)
    @access_token = access_token
  end
end
