require('pry-byebug')
require_relative('models/artist')
require_relative('models/album')

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' =>'Marylin Manson'})

artist1.save()


album1 = Album.new({
  'title' => 'Sweet Dreams',
  'genre' => 'metal',
  'artistID' => artist1.id
  })

album1.save()

album2 = Album.new({
  'title' => 'Sweet Dreams',
  'genre' => 'metal',
  'artistID' => artist1.id
  })

album2.save()

binding.pry
nil
