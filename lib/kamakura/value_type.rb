module Kamakura
  class ValueType
    def initialize(&parser)
      @parser = parser
    end

    def parse(value)
      @parser.call(value)
    end
  end

  String = ValueType.new do |value|
    value.nil? ? nil : Kernel.String(value)
  end

  Integer = ValueType.new do |value|
    value.nil? ? nil : Kernel.Integer(value) rescue nil
  end

  TRUE_VALUES = [true, "true", 1, "1"].freeze

  Boolean = ValueType.new do |value|
    value.nil? ? nil : TRUE_VALUES.include?(value)
  end
end
