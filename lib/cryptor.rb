require_relative 'enigma'

class Cryptor
  def self.crypt(dir, input, output, key = nil, date)
    enigma = Enigma.new
    symbols = [:encryption, :decryption, :decryption]
    message = File.read("./data/#{input}")
    encrypted = enigma.encrypt(message, key, date) if dir == 0
    encrypted = enigma.decrypt(message, key, date) if dir == 1
    encrypted = enigma.crack(message, date) if dir == 2
    File.open("./data/#{output}", 'w') do |f|
      f.write(encrypted[symbols[dir]])
    end
    puts "Created '#{input}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
  end
end