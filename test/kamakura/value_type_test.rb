require "test_helper"

class KamakuraValueTypeTest < Minitest::Test
  def test_string_parse
    string = Kamakura.lookup_value_type(:string)

    assert_nil string.parse(nil)
    assert_equal "abcd", string.parse("abcd")
    assert_equal "1234", string.parse(1234)
  end

  def test_integer_parse
    integer = Kamakura.lookup_value_type(:integer)

    assert_nil integer.parse("abcd")
    assert_nil integer.parse(nil)
    assert_equal 1234, integer.parse("1234")
  end

  def test_boolean_parse
    boolean = Kamakura.lookup_value_type(:boolean)

    assert_nil boolean.parse(nil)
    assert_equal true, boolean.parse(true)
    assert_equal true, boolean.parse("true")
    assert_equal true, boolean.parse(1)
    assert_equal true, boolean.parse("1")
    assert_equal false, boolean.parse(false)
    assert_equal false, boolean.parse("false")
    assert_equal false, boolean.parse(0)
    assert_equal false, boolean.parse("0")
  end

  def test_time_parse
    time = Kamakura.lookup_value_type(:time)

    assert_nil time.parse(nil)
    assert_equal Time.at(1), time.parse(1)
    assert_equal Time.at(1), time.parse("1")
  end
end
