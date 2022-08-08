require_relative './enigma'
require_relative './cryptor'
class Encrypt
  def self.start
    puts "Which direction? \nE or blank for encrypting, D for decrypting:"
    dir = gets.chomp.downcase
    if dir == 'd'
      dir = 1
    else
      dir = 0
    end

    puts "Enter name of source file:"
    input = gets.chomp

    puts "Enter name of output file:"
    output = gets.chomp

    puts "Enter key, leave blank for random:"
    key = gets.chomp
    key = nil if key == ''

    puts "Enter date, leave blank for today:"
    date = gets.chomp
    date = nil if date == ''

    Cryptor.crypt(dir, input, output, key, date)
  end
end

Encrypt.start
