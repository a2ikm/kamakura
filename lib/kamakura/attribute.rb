require "kamakura/collection_type"
require "kamakura/value_type"

module Kamakura
  class Attribute
    attr_reader :name, :type

    def initialize(name, type)
      @name = name.to_sym

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
