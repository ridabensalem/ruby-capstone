require_relative '../genre'

describe Genre do
  let(:genre) { Genre.new(name) }
  let(:name) { 'Rock' }
  let(:object) { double('Item') }

  context 'Initialize' do
    it 'sets name' do
      expect(genre.name).to eq(name)
    end

    it 'sets empty items array' do
      expect(genre.items).to be_empty
    end

    it 'adds item' do
      allow(object).to receive(:genre=)
      genre.add_item(object)
      expect(genre.items).to include(object)
    end
  end
end
