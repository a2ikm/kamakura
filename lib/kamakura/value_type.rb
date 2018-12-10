module Kamakura
  class ValueType
    def initialize(&parser)
      @parser = parser
    end

    def parse(value)
      @parser.call(value)
    end
  end

  class <<self
    def value_type_registory
      @value_type_registory ||= {}
    end

    def define_value_type(name, &block)
      value_type_registory[name] = ValueType.new(&block)
    end

    def lookup_value_type(name)
      value_type_registory[name]
    end
  end

  define_value_type(:string) do |value|
    value.nil? ? nil : Kernel.String(value)
  end

  define_value_type(:integer) do |value|
    value.nil? ? nil : Kernel.Integer(value) rescue nil
  end

  TRUE_VALUES = [true, "true", 1, "1"].freeze

  define_value_type(:boolean) do |value|
    value.nil? ? nil : TRUE_VALUES.include?(value)
  end

  define_value_type(:time) do |value|
    value.nil? ? nil : ::Time.at(value.to_i)
  end
end
