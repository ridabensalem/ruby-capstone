require_relative '../item'
require_relative '../label'

RSpec.describe Label do
  let(:label) { Label.new('Label 1', 'red', []) }
  let(:item1) { Item.new('Item 1', true) }
  let(:item2) { Item.new('Item 2', false) }

  describe '#initialize' do
    it 'sets the title, color, and items' do
      expect(label.title).to eq('Label 1')
      expect(label.color).to eq('red')
      expect(label.items).to eq([])
    end
  end

  describe 'test item methods' do
    it 'adds an item to the label' do
      label.add_item(item1, 'blue')
      expect(label.items).to eq([item1])
      expect(item1.label).to eq(label)
    end
  end
end
