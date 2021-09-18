module Foursquare
  class ResponseBody
    attr_reader :data

    def initialize(target_data:, data_class:)
      # 配列以外も扱うなら要変更 
      @data = target_data[data_class.array_key].map do |data|
        data_class.new(data)
      end
    end
  end
end
