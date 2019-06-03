require_relative( '../db/sql_runner' )

class Transaction

  attr_accessor :amount, :merchant_id, :tag_id, :transaction_date
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_f
    @merchant_id = options['merchant_id'].to_i if options['merchant_id']
    @tag_id = options['tag_id'].to_i if options['tag_id']
    @transaction_date = options['transaction_date'] if options['transaction_date']
  end

  def save()
    sql = "INSERT INTO transactions (amount, merchant_id, tag_id, transaction_date) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@amount.to_s, @merchant_id, @tag_id, @transaction_date]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def find()
    sql = "SELECT id, amount, transaction_date, merchant_id, tag_id FROM transactions WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return Transaction.new(result)
  end

  def find_merchant()
    sql = "SELECT merchants.name FROM transactions
    INNER JOIN merchants ON
    transactions.merchant_id = merchants.id
    WHERE transactions.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return result['name']
  end

  def find_tag()
    sql = "SELECT tags.name FROM transactions
    INNER JOIN tags ON
    transactions.tag_id = tags.id
    WHERE transactions.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return result['name']
  end

  def display_date()
    sql = "SELECT *, TO_CHAR(transaction_date, 'dd-Mon-YYYY')
    FROM transactions
    WHERE id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return result['to_char']
  end

  def self.all()
    sql = "SELECT id, amount, transaction_date, merchant_id, tag_id FROM transactions"
    results = SqlRunner.run(sql)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.find_by_id(id)
    sql = "SELECT id, amount, transaction_date, merchant_id, tag_id FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Transaction.new(result)
  end

  def delete()
    sql = "DELETE from transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.total()
    sql = "SELECT SUM (amount) as total_transactions FROM transactions;"
    result = SqlRunner.run(sql)
    return result.first['total_transactions'].to_f
  end


  def self.transaction_date()
    date = Time.new
    date = date.day.to_s + "/" + date.month.to_s + "/" + date.year.to_s
    return date
  end

  def self.sort_by_date()
    sql = "SELECT id, amount, transaction_date, merchant_id, tag_id FROM transactions order by transaction_date DESC"
    results = SqlRunner.run(sql)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  # def self.all_with_merchant_tag
  #   sql = "SELECT transactions.*, merchants.*, tags.* FROM transactions
  #   INNER JOIN merchants ON
  #   transactions.merchant_id = merchants.id
  #   INNER JOIN tags ON
  #   transactions.tag_id = tags.id"
  # end

  def self.filter_merchant(merchant_id)
    sql = "SELECT * from transactions WHERE merchant_id = $1"
    values = [merchant_id]
    results = SqlRunner.run(sql, values)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.total_by_merchant(merchant_id)
    sql = "SELECT SUM (amount) as total_transactions FROM transactions WHERE merchant_id = $1"
    values = [merchant_id]
    result = SqlRunner.run(sql, values)
    return result.first['total_transactions'].to_f
  end

  def self.filter_by_tag(tag_id)
    sql = "SELECT * from transactions WHERE tag_id = $1"
    values = [tag_id]
    results = SqlRunner.run(sql, values)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.total_by_tag(tag_id)
    sql = "SELECT SUM (amount) as total_transactions FROM transactions WHERE tag_id = $1"
    values = [tag_id]
    result = SqlRunner.run(sql, values)
    return result.first['total_transactions'].to_f
  end

  def self.filter_by_month(month_number)
    sql = "SELECT *, EXTRACT(MONTH FROM transaction_date) FROM transactions
    WHERE EXTRACT(MONTH FROM transaction_date) = $1"
    values = [month_number]
    results = SqlRunner.run(sql, values)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.total_by_month(month_number)
    sql = "SELECT *, EXTRACT(MONTH FROM transaction_date) FROM transactions
    WHERE EXTRACT(MONTH FROM transaction_date) = $1"
    values = [month_number]
    results = SqlRunner.run(sql, values)
    results = results.map{|transaction| transaction['amount'].to_f}
    return results.sum()
  end

end
