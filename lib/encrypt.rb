require_relative './enigma'

puts "Enter name of source file:"
input = 'message.txt' #gets.chomp

puts "Enter name of output file:"
output = 'encrypted.txt' #gets.chomp

message = File.read("./data/#{input}")
enigma = Enigma.new
encrypted = enigma.encrypt(message)
File.open("./data/#{output}", 'w') do |f|
  f.write(encrypted[:encryption])
end
