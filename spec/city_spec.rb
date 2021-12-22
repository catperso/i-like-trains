require 'city'
require 'spec_helper'

describe '#City' do

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city = City.new(name: "Portland")
      city2 = City.new(name: "Portland")
      expect(city).to(eq(city2))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no cities") do
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an city") do
      city = City.new(name: "Portland")
      city.save()
      expect(City.all).to(eq([city]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city = City.new(name: "Portland")
      city.save
      city2 = City.new(name: "Seattle")
      city2.save
      City.clear
      expect(City.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an city by id") do
      city = City.new(name: "Portland")
      city.save
      city2 = City.new(name: "Seattle")
      city2.save
      expect(City.find(city.id)).to(eq(city))
    end
  end

  describe('#update') do
    it("adds a train to a city") do
      city = City.new(name: "Portland")
      city.save()
      train = Train.new({name: "big train"})
      train.save()
      city.update({:train_name => "Blue"})
      assoc = DB.exec("SELECT * FROM trains_cities WHERE city_id = #{city.id} AND train_id = #{train.id};").first
      expect(assoc["train_id"].to_i).to(eq(train.id))
    end
  end
  
  describe('#update') do
    it("see if joined table has two rows of same thing") do
      city = City.new(name: "Portland")
      city.save()
      train = Train.new({name: "big train"})
      train.save()
      city.update({train_name: "big train"})
      city.update({train_name: "big train"})
      result = DB.exec("SELECT * FROM trains_cities WHERE city_id = #{city.id} AND train_id = #{train.id};")
      expect(result[1]).to(eq(1))
    end
  end

  describe('#delete') do
    it("deletes an train by id") do
      city = City.new(name: "Portland")
      city.save()
      city2 = City.new(name: "Seattle")
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end
  
  describe('#trains') do
    it("see if joined table has two rows of same thing") do
      city = City.new(name: "Portland")
      city.save()
      train = Train.new({name: "big train"})
      train.save()
      city.update({train_name: "big train"})
      expect(city.trains).to(eq(1))      
    end
  end

#   describe('.sort') do
#     it("sorts albums by name") do
#       album1 = Train.new("Giant Steps", "John Coltrane", "Jazz", 1960, nil)
#       album2 = Train.new("A Love Supreme", "John Coltrane", "Jazz", 1960,nil)
#       album3 = Train.new("Blue", "John Coltrane", "Jazz", 1960, nil)
#       album1.save()
#       album2.save()
#       album3.save()
#       Train.sort
#       expect(Train.all).to(eq([album2, album3, album1]))
#     end
#   end

#   describe('#songs') do
#     it("returns an train's songs") do
#       train = Train.new("Giant Steps", nil)
#       train.save()
#       song = Song.new("Naima", train.id, nil)
#       song.save()
#       song2 = Song.new("Cousin Mary", train.id, nil)
#       song2.save()
#       expect(train.songs).to(eq([song, song2]))
#     end
#   end
end