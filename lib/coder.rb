module Coder
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
end
