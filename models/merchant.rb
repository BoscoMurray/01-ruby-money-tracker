require_relative( '../db/sql_runner' )

class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save
    sql = "INSERT INTO merchants (name) VALUES (#{@name})
      RETURNING id"
    result = SqlRunner(sql)[0]
    @id = result['id'].to_i
  end

  

end