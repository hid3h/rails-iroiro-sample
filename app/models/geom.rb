class Geom < ApplicationRecord
  class << self
    def create_geom(lat:, long:)
      Armg.serializer = Armg::CustomSerializer.new
      create(location: "Point(#{lat} #{long})")
    end
  end
end
