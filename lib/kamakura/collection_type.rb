module Kamakura
  class CollectionType
    attr_reader :type

    def initialize(type)
      @type = type
    end

    def parse(value, **options)
      Array(value).map { |v| @type.parse(v, options) }
    end
  end
end
