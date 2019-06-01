require_relative( '../db/sql_runner' )

class Transaction

  attr_accessor :amount, :merchant_id, :tag_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_f
    @merchant_id = options['merchant_id'].to_i if options['merchant_id']
    @tag_id = options['tag_id'].to_i if options['tag_id']
  end

  def save()
    sql = "INSERT INTO transactions (amount, merchant_id, tag_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@amount.to_s, @merchant_id, @tag_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def find()
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return Transaction.new(result)
  end

  def find_merchant
    sql = "SELECT merchants.name FROM transactions
    INNER JOIN merchants ON
    transactions.merchant_id = merchants.id
    WHERE transactions.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return result['name']
  end

  def find_tag
    sql = "SELECT tags.name FROM transactions
    INNER JOIN tags ON
    transactions.tag_id = tags.id
    WHERE transactions.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return result['name']
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Transaction.new(result)
  end

  def self.total()
    sql = "SELECT SUM (amount) as total_transactions FROM transactions;"
    result = SqlRunner.run(sql)
    return result.first['total_transactions'].to_f
  end


  # def self.all_with_merchant_tag
  #   sql = "SELECT transactions.*, merchants.*, tags.* FROM transactions
  #   INNER JOIN merchants ON
  #   transactions.merchant_id = merchants.id
  #   INNER JOIN tags ON
  #   transactions.tag_id = tags.id"
  # end


end
