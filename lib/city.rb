class City
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def ==(city_to_compare)
    if city_to_compare != nil
      self.name() == city_to_compare.name()
    else
      false
    end
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    if city
      name = city.fetch("name")
      id = city.fetch("id").to_i
      City.new({:name => name, :id => id})
    else
      nil
    end
  end

  def update(name)
    @name = name
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def trains
    trains = []
    results = DB.exec("SELECT train_id FROM cities_trains WHERE city_id = #{@id};")
    results.each do |result|
      train_id = result.fetch("train_id").to_i
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first.fetch("name")
      trains.push(train.new({name: name, id: train_id}))
    end
    trains
  end

end
