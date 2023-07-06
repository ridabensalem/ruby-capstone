require_relative '../item'
require_relative '../author'

describe Item do
  let(:publish_date) { '2020/2/12' }
  let(:archived) { false }
  let(:object) { Item.new(publish_date, archived) }
  let(:genre) { double('Genre') }
  describe 'initialize' do
    it 'sets date' do
      expect(object.publish_date).to eq(publish_date)
    end
    it 'sets archived' do
      expect(object.archived).to eq(archived)
    end
  end
  describe 'test add methods' do
    it 'adds genre' do
      genre = object.add_genre('Rock')
      expect(genre).to be_an_instance_of(Genre)
    end
  end
  describe 'test move to archive if false  ' do
    it 'returns nil ' do
      expect(object.move_to_archive).to eq(nil)
    end
  end
  describe 'test can not  be archeived' do
    it 'returns false ' do
      expect(object.can_be_archived?).to eq(false)
    end
  end
end
