class Train
  attr_accessor :id, :name


  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each do |train|
      name = train.fetch("name")
      id = train.fetch("id")
      trains.push(Train.new({name: name, id: id}))
    end
    trains
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    name = train.fetch("name")
    id = train.fetch("id")
    Train.new({name: name, id: id})
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(other_train)
    self.name.eql?(other_train.name)
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def update(attributes)
    @name = attributes[:name] || @name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  def cities
    cities = []
    results = DB.exec("SELECT city_id FROM cities_trains WHERE train_id = #{@id};")
    results.each do |result|
      city_id = result.fetch("city_id").to_i
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first.fetch("name")
      cities.push(City.new({name: name, id: city_id}))
    end
    cities
  end

end