require "date"

module Kamakura
  class ValueType
    def initialize(&parser)
      @parser = parser
    end

    def parse(value, **options)
      @parser.call(value, options)
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

  define_value_type(:string) do |value, **options|
    value.nil? ? nil : Kernel.String(value)
  end

  define_value_type(:integer) do |value, **options|
    value.nil? ? nil : Kernel.Integer(value) rescue nil
  end

  TRUE_VALUES = [true, "true", 1, "1"].freeze

  define_value_type(:boolean) do |value, **options|
    value.nil? ? nil : TRUE_VALUES.include?(value)
  end

  define_value_type(:time) do |value, **options|
    if value.nil?
      nil
    elsif value.is_a?(Time)
      value
    else
      Time.at(value.to_i)
    end
  end

  DATE_FORMATS = {
    httpdate:   ->(value) { Date.httpdate(value) },
    iso8601:    ->(value) { Date.iso8601(value) },
    jd:         ->(value) { Date.jd(value) },
    jisx8601:   ->(value) { Date.jisx8601(value) },
    rfc2822:    ->(value) { Date.rfc2822(value) },
    rfc3339:    ->(value) { Date.rfc3339(value) },
    rfc822:     ->(value) { Date.rfc822(value) },
    xmlschema:  ->(value) { Date.xmlschema(value) },
  }

  define_value_type(:date) do |value, **options|
    if value.nil?
      nil
    elsif value.is_a?(Date)
      value
    else
      format = options[:format]
      if parser = DATE_FORMATS[format]
        parser.call(value)
      elsif format.is_a?(String)
        Date.strptime(value, format)
      else
        Date.parse(value)
      end
    end
  end

  DATETIME_FORMATS = {
    httpdate:   ->(value) { DateTime.httpdate(value) },
    iso8601:    ->(value) { DateTime.iso8601(value) },
    jd:         ->(value) { DateTime.jd(value) },
    jisx8601:   ->(value) { DateTime.jisx8601(value) },
    rfc2822:    ->(value) { DateTime.rfc2822(value) },
    rfc3339:    ->(value) { DateTime.rfc3339(value) },
    rfc822:     ->(value) { DateTime.rfc822(value) },
    xmlschema:  ->(value) { DateTime.xmlschema(value) },
  }

  define_value_type(:datetime) do |value, **options|
    if value.nil?
      nil
    elsif value.is_a?(DateTime)
      value
    else
      format = options[:format]
      if parser = DATETIME_FORMATS[format]
        parser.call(value)
      elsif format.is_a?(String)
        DateTime.strptime(value, format)
      else
        DateTime.parse(value)
      end
    end
  end
end
