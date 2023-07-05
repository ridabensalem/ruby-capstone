require_relative '../music_album'
require_relative '../item'
require 'date'

describe MusicAlbum do
    let(:name) { 'Cater V' }
    let(:publish_date) { Date.new(2023, 7, 5) }
    let(:on_spotify) { 'Yes' }
    let(:music_album) { MusicAlbum.new(name, publish_date, on_spotify) }
    
    context 'initialize' do
        it 'sets name' do
            expect(music_album.name).to eq(name)
        end 

        it 'sets date' do
            expect(music_album.publish_date).to eq(publish_date)
        end

        it 'sets on_spotify' do
            expect(music_album.on_spotify).to eq(on_spotify)
        end

        it 'tests can_be_archived? method' do
            album = MusicAlbum.new("Album Name", "2021-01-01", true)
            expect(album.can_be_archived?).to eq(false)
        end
    end
end