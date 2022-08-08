require_relative './enigma'

puts "Enter name of source file:"
input = gets.chomp

puts "Enter name of output file:"
output =  gets.chomp

puts "Enter key:"
key = gets.chomp

message = File.read("./data/#{input}")
enigma = Enigma.new
encrypted = enigma.decrypt(message, key)
File.open("./data/#{output}", 'w') do |f|
  f.write(encrypted[:message])
end
