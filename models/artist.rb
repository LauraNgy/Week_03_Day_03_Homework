require_relative('../db/sqlrunner')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql =
          "INSERT INTO artists
          (name)
          VALUES
          ($1)
          RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql =
          "UPDATE artists
          SET
          name = $1
          WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql =
          "DELETE FROM artists
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def albums()
    sql =
          "SELECT * FROM albums
          WHERE artistID = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |param| Album.new(param) }
  end

  def Artist.all()
    sql =
          "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist)}
  end

  def Artist.delete_all()
    sql =
          "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def Artist.find_by_id(id)
    sql =
          "SELECT * FROM artists
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map { |param| Artist.new(param) }
  end

end
