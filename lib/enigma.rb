require 'date'
require 'pry'

class Enigma
  def encrypt(message, key = nil, date = nil)
    keys = key_manager(key)
    offsets = date_manager(date)
    shifts = shift(keys, offsets)
    cipher = code(message, shifts)
    {
      encryption: cipher.join,
      key: keys.values.to_s.gsub(/., |\[|\]/, '').rjust(5, '0'),
      date: date ||= date_gen
    }
  end

  def decrypt(cipher, key, date = nil)
    keys = key_manager(key)
    offsets = date_manager(date)
    shifts = shift(keys, offsets)
    message = code(cipher, shifts, -1)
    {
      message: message.join,
      key: keys.values.to_s.gsub(/., |\[|\]/, '').rjust(5, '0'),
      date: date ||= date_gen
    }
  end

  def crack(ciphertext, date = nil)
    length = ciphertext.length
    terminal = Hash[(length - 4..length - 1).to_a.zip(ciphertext[-4..].split(''))]
    offsets = date_manager(date)
    keys = key_crkr(terminal, offsets)
    shifts = shift(keys, offsets)
    message = code(ciphertext, shifts, -1)
    {
      message: message.join,
      key: keys.values.to_s.gsub(/., |\[|\]/, '').rjust(5, '0'),
      date: date
    }
  end

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
    %w[A B C D].reduce(Hash.new('')) do |hash, letter|
      hash[letter] = date[index].to_i
      index += 1
      hash
    end
  end

  def key_gen
    Random.new.rand(99_999)
  end

  def date_gen
    date = Time.new
    date.strftime("%d%m%y")
  end

  def code(message, shifts, dir = 1)
    char_set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    msg_chars = message.downcase.split('')
    keys = %w[A B C D]
    msg_chars.each_with_index do |char, msg_index = 0|
      shft_index = msg_index % 4
      if char_set.include?(char)
        char_id = char_set.find_index(char)
        msg_chars[msg_index] = char_set[(char_id + (dir * shifts[keys[shft_index]])) % 27]
      end
    end
  end

  def key_crkr(terminal, offsets)
    keys = %w[A B C D]
    msg_chars = unoffset(terminal, offsets, keys)
    counters = rotate_counter(msg_chars)
    count_keys = counters.zip(terminal.keys)
    count_keys.rotate!(1).to_h until (count_keys[0][1] % 4).zero?
    Hash[keys.zip(count_keys.to_h.keys)]
  end

  def unoffset(terminal, offsets, keys)
    char_set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    msg_chars = terminal.values
    msg_chars.each_with_index do |char, msg_index = 0|
      shft_index = terminal.keys[msg_index] % 4
      char_id = char_set.find_index(char)
      msg_chars[msg_index] = char_set[(char_id - offsets[keys[shft_index]]) % 27]
    end
  end

  def rotate_counter(msg_chars)
    msg_chars.each_with_index.map do |char, index|
      temp_set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
      counter = 0
      char_index = temp_set.find_index(char)
      until [' ', 'e', 'n', 'd'][index] == temp_set[char_index]
        temp_set.rotate!(-1)
        counter += 1
      end
      counter
    end
  end
end
