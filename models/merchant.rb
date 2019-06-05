require_relative( '../db/sql_runner' )

class Merchant

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def delete()
    sql = "DELETE from merchants WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def find()
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return Merchant.new(result)
  end

  def update()
    sql = "UPDATE merchants SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Merchant.new(result)
  end


  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run(sql)
    return results.map{|merchant| Merchant.new(merchant)}
  end

  def self.delete_all()
    sql = "DELETE from merchants"
    SqlRunner.run(sql)
  end

  def self.find_merchant(tag_id)
    sql = "SELECT name FROM merchants WHERE id = $1"
    values = [tag_id]
    result = SqlRunner.run(sql, values)[0]
    return result['name']
  end


end
