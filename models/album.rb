require_relative('../db/sqlrunner')

class Album

  attr_reader :id
  attr_accessor :title, :genre, :artistID #you can make artistID an attr_accessror in case you mis-assigned the artist

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @artistID = options['artistID'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql =
          "INSERT INTO albums
          (title, genre, artistID)
          VALUES
          ($1, $2, $3)
          RETURNING *"
    values = [@title, @genre, @artistID]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql =
        "UPDATE albums
        SET (title, genre, artistID) = ($1, $2, $3)
        WHERE id = $4"
    values = [@title, @genre, @artistID, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql =
          "DELETE FROM albums
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql =
          "SELECT * FROM artists
          WHERE id = $1"
    values = [@artistID]
    result = SqlRunner.run(sql, values)
    return result.map { |param| Artist.new(param) }[0]
  end

  def Album.all()
    sql =
          "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album)}
  end

  def Album.delete_all()
    sql =
          "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def Album.find_by_id(id)
    sql =
          "SELECT * FROM albums
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map { |param| Album.new(param) }
  end


end
