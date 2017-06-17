require_relative( '../db/sql_runner' )

class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO merchants (name) VALUES ('#{@name}')
      RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    unsorted = merchants.map { |merchant| Merchant.new(merchant) }
    return unsorted.sort_by { |t| [t.name] }
  end

  def self.delete_all
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM merchants WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end