require 'date'
require 'pry'

class Enigma
  def initialize
  end
  
  def encrypt(message, key = nil, date = nil)
    keys = key_manager(key)
    offsets = date_manager(date)
    shifts = shift(keys, offsets)
    #binding.pry
    cipher = encode(message, shifts)
    {
      encryption: cipher.join,
      key: keys.values.to_s.gsub(/., |\[|\]/,'').rjust(5,'0'),
      date: date ||= date_gen
    }
  end

  # def decrypt(message, key, date = nil)
  # end

  # def crack
  # end

  private

  def shift(keys, offsets)
    Hash[keys.map { |k, v| [k, v + offsets[k]] }]
  end

  def key_manager(key)
    key ||= key_gen
    key = key.to_s.rjust(5, '0')
    index = 0
    %w[A B C D].reduce(Hash.new('')) do |hash, letter|
      hash[letter] = key[index..index + 1].to_i
      index += 1
      hash
    end
  end

  def date_manager(date)
    date ||= date_gen
    date = (date.to_i**2).to_s[-4..-1]
    index = 0
    #binding.pry
    %w[A B C D].reduce(Hash.new('')) do |hash, letter|
      hash[letter] = date[index].to_i
      index += 1
      hash
    end
  end

  def key_gen
    Random.new.rand(99999)
  end

  def date_gen
    date = Time.new
    date.strftime("%d%m%y")
  end

  def encode(message, shifts)
    char_set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    msg_chars = message.downcase.split('')
    keys = %w[A B C D]
    msg_index = 0
    
    msg_chars.each do |char|
      shft_index = msg_index % 4
      if char_set.include?(char)
        char_id = char_set.find_index(char)
        msg_chars[msg_index] = char_set[(char_id + shifts[keys[shft_index]]) % 27]
      end
      msg_index += 1
    end
    msg_chars
  end
end
