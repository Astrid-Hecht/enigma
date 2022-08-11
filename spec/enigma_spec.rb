require_relative './spec_helper'
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

    it 'can encrypt a message with a special character' do
      expect(@enigma.encrypt('hello world!', '02715', '040895')).to eq(
      {
        encryption: 'keder ohulw!',
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

    describe 'helper methods' do 
      it 'key_gen generates random 5 digit number' do
        range = []
        10000.times do 
          range << @enigma.send(:key_gen)
        end
        expect(range.max > 0).to be true
        expect(range.min < 100000).to be true
      end

      it 'date_gen generate dates in a DDMMYY digit format' do 
        time = Time.new
        date = @enigma.send(:date_gen)
        expect(date.length).to eq(6)
        expect(date[0..1]).to eq(time.day.to_s.rjust(2,"0"))
        expect(date[2..3]).to eq(time.month.to_s.rjust(2,"0"))
        expect(date[4..5]).to eq(time.year.to_s[-2..-1])
      end
    end
  end

  describe '#decrypt' do
    it 'can decrypt a message with a key and date' do
      expect(@enigma.decrypt('keder ohulw', '02715', '040895')).to eq(
      {
        decryption: 'hello world',
        key: '02715',
        date: '040895'
      })
    end

    it "can decrypt a message with a key (uses today's date)" do
      encrypted = @enigma.encrypt('hello world', '02715')
      expect(@enigma.decrypt(encrypted[:encryption], '02715')).to eq(
      {
        decryption: 'hello world',
        key: '02715',
        date: @date
      })
    end
  end

  describe '#crack' do
    it 'can decode messages from today ending w " end"' do
      encrypted = @enigma.encrypt('hello world end')
      expect(@enigma.crack(encrypted[:encryption])[:decryption]).to eq('hello world end')
    end

    it 'can crack messages from the past with a known date' do 
      allow(@enigma).to receive(:date_gen) { '040895' }
      encrypted = @enigma.encrypt('hello world end')
      expect(@enigma.crack(encrypted[:encryption], '040895')[:decryption]).to eq('hello world end')
    end
  end
end
