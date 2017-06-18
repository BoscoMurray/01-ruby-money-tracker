require('minitest/autorun')
require('minitest/rg')
require('pry-byebug')
require_relative('../transaction')

class TransactionTest < MiniTest::Test

  def setup

    @transaction1 = Transaction.new({
      "id" => 1,
      "amount" => 49,
      "date" => "2017-06-01",
      "merchant_id" => 2,
      "tag_id" => 3
      })

    @transaction2 = Transaction.new({
      "id" => 2,
      "amount" => 50,
      "date" => "2017-05-10",
      "merchant_id" => 4,
      "tag_id" => 5
      })

  end

  def test_id
    assert_equal(1, @transaction1.id)
  end

  def test_amount
    assert_equal(50, @transaction2.amount)
  end

  def test_date
    assert_equal("2017-05-10", @transaction2.date)
  end

  def test_merchant_id
    assert_equal(4, @transaction2.merchant_id)
  end

  def test_tag_id
    assert_equal(5, @transaction2.tag_id)
  end

  def test_date_range
    txs = [@transaction1, @transaction2]
    assert_equal( 1, Transaction.date_range( txs, "2017-05-01", "2017-05-30" ).count )
  end

end