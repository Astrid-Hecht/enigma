class Enigma
def encrypt(message, key = nil, date = nil)
  
end

# def decrypt(message, key, date = nil)
# end

# def crack
# end

private

def key_gen
  Random.new.rand(99999).to_s.rjust(5, '0')
end
