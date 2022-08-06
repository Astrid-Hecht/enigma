require_relative '../lib/enigma'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
    @date = Time.new.strftime("%d%m%y")
  end

  describe '#encrypt' do
    it 'can encrypt a message with a key and date' do
      expect(@enigma.encrypt('hello world', '02715', '040895')).to eq(
      {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      })
    end

    it "can encrypt a message with a key (uses today's date)" do
      allow(@enigma).to receive(:date_gen) { '060822' }
      expect(@enigma.encrypt('hello world', '02715')).to eq(
      {
        encryption: 'okjdvfugyrb',
        key: '02715',
        date: '060822'
      })
      allow(@enigma).to receive(:date_gen) { '040895' }
      expect(@enigma.encrypt('hello world', '02715')).to eq(
      {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      })
    end

    it "can encrypt a message (generates random key and uses today's date)" do
      allow(@enigma).to receive(:key_gen) { 2715 }
      allow(@enigma).to receive(:date_gen) { '060822' }
      expect(@enigma.encrypt('hello world')).to eq(
      {
        encryption: 'okjdvfugyrb',
        key: '02715',
        date: '060822'
      })
      allow(@enigma).to receive(:key_gen) { 2715 }
      allow(@enigma).to receive(:date_gen) { '040895' }
      expect(@enigma.encrypt('hello world')).to eq(
      {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      })
    end
  end

  # describe '#decrypt' do
  #   it 'can decrypt a message with a key and date' do
  #     expect(@enigma.decrypt('keder ohulw', '02715', '040895')).to eq
  #     {
  #       encryption: 'hello world',
  #       key: '02715',
  #       date: '040895'
  #     }
  #   end

  #   it "can decrypt a message with a key (uses today's date)" do
  #     encrypted = @enigma.encrypt('hello world', '02715')
  #     expect(@enigma.decrypt(encrypted[:encryption], '02715')).to eq
  #     {
  #       encryption: 'hello world',
  #       key: '02715',
  #       date: '040895'
  #     }
  #   end
  # end

  # describe '#crack' do
  # end
end
