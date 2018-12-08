module Kamakura
  class AttributeType
    def initialize(&parser)
      @parser = parser
    end

    def parse(value)
      @parser.call(value)
    end
  end

  String = AttributeType.new do |value|
    value.nil? ? nil : Kernel.String(value)
  end

  Integer = AttributeType.new do |value|
    value.nil? ? nil : Kernel.Integer(value) rescue nil
  end
end
