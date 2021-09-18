require 'foursquare/response_body'
require 'foursquare/response_data'

module Foursquare
  class Client
    API_BASE_URL          = 'https://api.foursquare.com/v2'
    DEFAULT_SUGGEST_LIMIT = 30

    # FoursquareAPIに仕様変更があっても指定した日付時点での仕様でFoursquareAPIを利用できる
    API_VERSION = '20210918'

    RESPONSE_DATA_CLASS_MAPPING = {
      minivenue: Foursquare::ResponseData::Minivenue
    }

    def initialize
      @client_id     = ENV['FOURSQAURE_CLIENT_ID']
      @client_secret = ENV['FOURSQAURE_CLIENT_SECRET']
      @version       = API_VERSION
    end

    def suggest(query:, lat:, long:, limit: DEFAULT_SUGGEST_LIMIT)
      send_request(
        data_class_name: :minivenue, # 取得した情報を詰めるClassの名前を指定する
        path:            'venues/suggestcompletion',
        params:          {
                            query: query,
                            ll:    "#{lat},#{long}",
                            limit: limit
                          }
      )
    end

    private

    def send_request(data_class_name:, path:, params:)
      response = connection.get(path) do |req|
        params.each do |k, v|
          req.params[k] = v
        end
      end
      response_body = JSON.parse(response.body)
      p "responsebody", response_body
      meta = response_body['meta']
      if meta['code'] == 200
        Foursquare::ResponseBody.new(
          target_data: response_body['response'],
          data_class:  data_class_of(data_class_name)
        )
      else
        # エラーをRaiseするなど
      end
    end

    # Faradayを使ってリクエストする
    def connection
      params = {
        client_id:     @client_id,
        client_secret: @client_secret,
        v:             @version
      }
      @connection ||= Faraday.new(url: API_BASE_URL, params: params)
    end

    def data_class_of(data_class_name)
      RESPONSE_DATA_CLASS_MAPPING.fetch(data_class_name)
    end
  end
end
