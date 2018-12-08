require "kamakura/collection_type"
require "kamakura/value_type"

module Kamakura
  class Attribute
    attr_reader :name, :type, :key

    def initialize(name, type, key: nil)
      @name = name.to_sym
      @key = key ? key.to_sym : @name

      if type.is_a?(Array)
        @type = CollectionType.new(type[0])
      else
        @type = type
      end
    end

    def parse(value)
      @type.parse(value)
    end
  end
end
