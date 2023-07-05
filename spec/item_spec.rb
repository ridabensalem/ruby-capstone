require_relative '../item'

describe Item do
    let(:publish_date) { "2020/2/12" }
    let(:archived) { false }
    let(:item) { Item.new(publish_date, archived) }
    let(:genre) { double('Genre') }

    describe 'initialize' do
        it 'sets date' do
            expect(item.publish_date).to eq(publish_date)
        end

        it 'sets archived' do
            expect(item.archived).to eq(archived)
        end
    end

    describe 'test add methods' do
        it 'adds genre' do
            genre = item.add_genre('Rock')
            expect(genre).to be_an_instance_of(Genre)
        end
    end
end