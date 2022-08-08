require_relative 'coder'
require_relative 'detail_manager'
require_relative 'cracker'

class Enigma
  include Coder
  include DetailManager
  include Cracker

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
      decryption: message.join,
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
      decryption: message.join,
      key: keys.values.to_s.gsub(/., |\[|\]/, '').rjust(5, '0'),
      date: date ||= date_gen
    }
  end
end
