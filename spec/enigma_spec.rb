require_relative '../lib/enigma'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
  end

  describe '#encrypt' do
    it 'can encrypt a message with a key and date' do
      expect(@enigma.encrypt('hello world', '02715', '040895')).to eq 
      {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
    end

    it "can encrypt a message with a key (uses today's date)" do
      expect(@enigma.enigma.encrypt('hello world', '02715')).to eq 
      {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
    end

    it "can encrypt a message (generates random key and uses today's date)" do
      expect(enigma.encrypt('hello world')).to eq
      {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }
    end
  end

  describe '#decrypt' do
    it 'can decrypt a message with a key and date' do
      expect(@enigma.decrypt('keder ohulw', '02715', '040895')).to eq
      {
        encryption: 'hello world',
        key: '02715',
        date: '040895'
      }
    end

    it "can decrypt a message with a key (uses today's date)" do
      encrypted = enigma.encrypt('hello world', '02715')
      expect(@enigma.decrypt(encrypted[:encryption], '02715')).to eq
      {
        encryption: 'hello world',
        key: '02715',
        date: '040895'
      }
    end
  end

  # describe '#crack' do
  # end
end
