require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction.rb')


class TestTransaction < MiniTest::Test

  def setup

  end

  def test_total_transactions
    assert_equal(179.77, Transaction.total())
  end

  def test_transaction_date
    assert_equal("2/6/2019", Transaction.transaction_date())
  end

end
