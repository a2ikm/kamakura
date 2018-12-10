require "test_helper"

class KamakuraValueTypeTest < Minitest::Test
  def test_string_parse
    assert_equal "abcd", lookup_value_type(:string).parse("abcd")
    assert_nil lookup_value_type(:string).parse(nil)
    assert_equal "1234", lookup_value_type(:string).parse(1234)
  end

  def test_integer_parse
    assert_nil lookup_value_type(:integer).parse("abcd")
    assert_nil lookup_value_type(:integer).parse(nil)
    assert_equal 1234, lookup_value_type(:integer).parse("1234")
  end

  def test_boolean_parse
    assert_nil lookup_value_type(:boolean).parse(nil)

    assert_equal true, lookup_value_type(:boolean).parse(true)
    assert_equal true, lookup_value_type(:boolean).parse("true")
    assert_equal true, lookup_value_type(:boolean).parse(1)
    assert_equal true, lookup_value_type(:boolean).parse("1")

    assert_equal false, lookup_value_type(:boolean).parse(false)
    assert_equal false, lookup_value_type(:boolean).parse("false")
    assert_equal false, lookup_value_type(:boolean).parse(0)
    assert_equal false, lookup_value_type(:boolean).parse("0")
  end

  def test_time_parse
    assert_nil lookup_value_type(:time).parse(nil)
    assert_equal Time.at(1), lookup_value_type(:time).parse(1)
    assert_equal Time.at(1), lookup_value_type(:time).parse("1")
  end

  private

  def lookup_value_type(name)
    Kamakura.lookup_value_type(name)
  end
end
