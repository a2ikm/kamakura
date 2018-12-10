require "kamakura/collection_type"
require "kamakura/value_type"

module Kamakura
  class Attribute
    attr_reader :name, :type, :key, :options

    def initialize(name, type, key: nil, **options)
      @name = name.to_sym
      @key = key ? key.to_sym : @name
      @options = options

      if type.is_a?(Array)
        if value_type = Kamakura.lookup_value_type(type[0])
          @type = CollectionType.new(value_type)
        else
          @type = CollectionType.new(type[0])
        end
      elsif value_type = Kamakura.lookup_value_type(type)
        @type = value_type
      else
        @type = type
      end
    end

    def parse(value)
      @type.parse(value, @options)
    end
  end
end
