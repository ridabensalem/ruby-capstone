require_relative '../item'
require_relative '../book'

RSpec.describe Book do
  let(:book) { Book.new('Publisher 1', 'good') }

  describe '#initialize' do
    it 'sets the publisher' do
      expect(book.publisher).to eq('Publisher 1')
    end

    it 'sets the cover_state' do
      expect(book.cover_state).to eq('good')
    end

    it 'sets the publish_date to nil' do
      expect(book.publish_date).to be_nil
    end
  end
end
