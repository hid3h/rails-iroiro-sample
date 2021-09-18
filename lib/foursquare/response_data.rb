module Foursquare
  class ResponseData
    class Minivenue
      attr_reader :id
      attr_reader :name
      attr_reader :category_icon_url

      ICON_SIZE_PX = 64

      def self.array_key
        'minivenues'
      end

      def initialize(data)
        @id       = data['id']
        @name     = data['name']
        @location = data['location']
        @category = set_category_icon_url(data['categories'])
      end

      def lat
        @location['lat']
      end

      def long
        @location['lng']
      end

      private

      def set_category_icon_url(categories)
        category = categories.find { |c| c['primary'] }
        return nil if category.nil?
        # アイコンの画像URLは次のように生成できます: https://developer.foursquare.com/docs/api-reference/venues/categories/#response-fields
        @category_icon_url = "#{category['icon']['prefix']}#{ICON_SIZE_PX}#{category['icon']['suffix']}"
      end
    end
  end
end
