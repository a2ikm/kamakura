module Kamakura
  class CollectionType
    attr_reader :type

    def initialize(type)
      @type = type
    end

    def parse(value)
      Array(value).map { |v| @type.parse(v) }
    end
  end
end
