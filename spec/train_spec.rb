require 'train'
require 'spec_helper'

describe '#Train' do

  describe('.all') do
    it("returns an empty array when there are no trains") do
      expect(Train.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an train by id") do
      train = Train.new({name: "big train"})
      train.save()
      train2 = Train.new({name: "small train"})
      train2.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end

  describe('#save') do
    it("saves a train") do
      train = Train.new({name: "big train"})
      train.save()
      train2 = Train.new({name: "small train"})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train = Train.new({name: "big train"})
      train2 = Train.new({name: "big train"})
      expect(train).to(eq(train2))
    end
  end

  describe('.clear') do
    it("clears all trains") do
      train = Train.new({name: "big train"})
      train.save()
      train2 = Train.new({name: "small train"})
      train2.save()
      Train.clear()
      expect(Train.all).to(eq([]))
    end
  end

  describe('#update') do
    it("updates an train by id") do
      train = Train.new({name: "big train"})
      train.save()
      train.update(name: "small train")
      expect(train.name).to(eq("small train"))
    end
  end

  describe('#delete') do
    it("deletes an train by id") do
      train = Train.new({name: "big train"})
      train.save()
      train2 = Train.new({name: "small train"})
      train2.save()
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

  describe('#cities') do
    it("returns a trains's cities") do
      train = Train.new({name: "big train"})
      train.save()
      city = City.new(name: "Portland")
      city.save()
      city2 = City.new(name: "Seattle")
      city2.save()
      expect(train.citys).to(eq([city, city2]))
    end
  end

end