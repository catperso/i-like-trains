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
    it("saves a city") do
      city = City.new({name: "Portland"})
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
    it("finds a city by id") do
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
      city.update({train_name: train.name})
      assoc = DB.exec("SELECT * FROM cities_trains WHERE city_id = #{city.id} AND train_id = #{train.id};").first
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
      result = DB.exec("SELECT * FROM cities_trains WHERE city_id = #{city.id} AND train_id = #{train.id};")
      expect(result[1]).to(eq(1))
    end
  end

  describe('#delete') do
    it("deletes a train by id") do
      city = City.new(name: "Portland")
      city.save()
      city2 = City.new(name: "Seattle")
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end
  
  describe('#trains') do
    it("returns a city's trains") do
      city = City.new(name: "Portland")
      city.save()
      train = Train.new({name: "big train"})
      train.save()
      city.update({train_name: "big train"})
      expect(city.trains).to(eq([train]))      
    end
  end

end