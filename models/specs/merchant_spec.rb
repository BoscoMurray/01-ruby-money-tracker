require('minitest/autorun')
require('minitest/rg')
require('pry-byebug')
require_relative('../merchant')

class MerchantTest < MiniTest::Test

  def setup

    @merchant1 = Merchant.new({
      "id" => 1,
      "name" => "amazon"
      })

    @merchant2 = Merchant.new({
      "id" => 2,
      "name" => "lidl"
      })

  end

  def test_id
    assert_equal(1, @merchant1.id)
  end

  def test_name
    assert_equal("lidl", @merchant2.name)
  end

end