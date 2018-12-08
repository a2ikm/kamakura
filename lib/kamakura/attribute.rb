require "kamakura/value_type"

module Kamakura
  class Attribute
    attr_reader :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    def parse(value)
      @type.parse(value)
    end
  end
end
