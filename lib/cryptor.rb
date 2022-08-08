require_relative 'enigma'

class Cryptor
  def self.crypt(dir, input, output, key, date)
    enigma = Enigma.new
    symbols = [:encryption, :message]
    message = File.read("./data/#{input}")
    encrypted = enigma.encrypt(message, key, date) if dir.zero?
    encrypted = enigma.decrypt(message, key, date) if dir == 1
    File.open("./data/#{output}", 'w') do |f|
      f.write(encrypted[symbols[dir]])
    end
    puts "Created '#{input}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
  end
end