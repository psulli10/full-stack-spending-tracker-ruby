require_relative( '../db/sql_runner' )

class Tag

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ($1) RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def delete()
    sql = "DELETE from tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def find()
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)[0]
    return Tag.new(result)
  end

  def update()
    sql = "UPDATE tags SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Tag.new(result)
  end

  def self.all()
    sql = "SELECT * FROM tags"
    results = SqlRunner.run(sql)
    return results.map{|tag| Tag.new(tag)}
  end

  def self.delete_all()
    sql = "DELETE from tags"
    SqlRunner.run(sql)
  end


end
