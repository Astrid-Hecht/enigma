require_relative './enigma'
require_relative './cryptor'
class Encrypt
  def self.start
    puts "Which direction? \nE or blank for encrypting, D for decrypting, C for cracking:"
    @dir = gets.chomp.downcase
    case @dir
    when 'c'
      @dir = 2
      continue
    when 'd'
      @dir = 1
      continue
    when 'e' || ''
      @dir = 0
      continue
    else
      puts "Invalid input, try again.\n"
      start
    end
  end

  def self.continue

    puts "\nEnter name of source file:"
    input = gets.chomp

    puts 'Enter name of output file:'
    output = gets.chomp

    if @dir == 1 || @dir == 0
      puts 'Enter key, leave blank for random:'
      key = gets.chomp
      key = nil if key == ''
    else
      key = nil
    end

    puts 'Enter date, leave blank for today:'
    date = gets.chomp
    date = nil if date == ''

    Cryptor.crypt(@dir, input, output, key, date)
  end
end

Encrypt.start
