require_relative( '../db/sql_runner' )
require_relative('./transaction')

class Budget

  attr_accessor :total, :warning_limit, :message, :message_indicator
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @total = options['total'].to_f
    @warning_limit = options['warning_limit'].to_f
    @message = options['message']
    @message_indicator = options['message_indicator'] if options['message_indicator']
  end

  def save()
    sql = "INSERT INTO budgets (total, warning_limit, message) VALUES ($1, $2, $3) RETURNING id"
    values = [@total, @warning_limit, @message]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def delete()
    sql = "DELETE from budgets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def find()
    sql = "SELECT * FROM budgets WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return Budget.new(result)
  end

  def update()
    sql = "UPDATE budgets SET (total, warning_limit, message, message_indicator) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@total, @warning_limit, @message, @message_indicator, @id]
    SqlRunner.run(sql, values)
  end

  def remaining_budget()
    total_transactions = Transaction.total()
    remaining_budget = @total - total_transactions
    return remaining_budget
  end

  def update_message()
    remaining_budget = remaining_budget()
    if remaining_budget > @warning_limit
      @message = "Nah! You're flush, spend away..."
      @message_indicator = "green"
    elsif remaining_budget <= @warning_limit && remaining_budget > 0
      @message = "Almost... keep an eye on the pennies"
      @message_indicator = "yellow"
    elsif remaining_budget <= 0
      @message = "Aye, you're skint! Bread and water from now on"
      @message_indicator = "red"
    end
    update()
  end

  def pretty_number(amount)
    number = amount.to_s.split(".")
    if number[1].size() < 2
      number[1] << "0"
    end
    return number.join(".")
  end


  def self.find_by_id(id)
    sql = "SELECT * FROM budgets WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Budget.new(result)
  end

  def self.all()
    sql = "SELECT * FROM budgets"
    results = SqlRunner.run(sql)
    return results.map{|budget| Budget.new(budget)}
  end

  def self.delete_all()
    sql = "DELETE from budgets"
    SqlRunner.run(sql)
  end

  def self.remaining_budget()
    total_transactions = Transaction.total()
    sql = "Select total from budgets"
    results_array = SqlRunner.run(sql)[0]
    results_budget = results_array['total'].to_f
    remaining_budget = results_budget - total_transactions
    return remaining_budget
  end

  def self.update_message()
    @budget = Budget.all()[0]
    remaining_budget = @budget.remaining_budget()
    if remaining_budget > @budget.warning_limit()
      @budget.message = "Nah! You're flush, spend away..."
      @budget.message_indicator = "green"
    elsif remaining_budget <= @budget.warning_limit() && remaining_budget > 0
      @budget.message = "Almost... keep an eye on the pennies"
      @budget.message_indicator = "yellow"
    elsif remaining_budget <= 0
      @budget.message = "Aye, you're skint, bread and water from now on"
      @budget.message_indicator = "red"
    end
    @budget.update()
  end

  def self.pretty_number(amount)
    number = amount.to_s.split(".")
    if number[1].size() < 2
      number[1] << "0"
    end
    return number.join(".")
  end

end
