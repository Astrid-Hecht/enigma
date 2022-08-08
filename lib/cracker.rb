module Cracker
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
