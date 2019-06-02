require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction.rb')
require_relative('../budget.rb')


class TestTransaction < MiniTest::Test

  def setup

  end

  def test_total_transactions
    assert_equal(179.77, Transaction.total())
  end

  def test_transaction_date
    assert_equal("2/6/2019", Transaction.transaction_date())
  end

  def test_remaining_budget
    assert_equal(320.23, budget1.remaining_budget)
  end


end
