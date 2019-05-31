require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction.rb')


class TestTransaction < MiniTest::Test

  def setup

  end

  def test_total_transactions
    assert_equal(179.77, Transaction.total())
  end

end
