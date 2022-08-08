require_relative './enigma'

puts "Enter name of source file:"
input = gets.chomp

puts "Enter name of output file:"
output = gets.chomp

message = File.read("./data/#{input}")
enigma = Enigma.new
encrypted = enigma.encrypt(message)
File.open("./data/#{output}", 'w') do |f|
  f.write(encrypted[:encryption])
end

puts "Created '#{input}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
