require 'date'

module DetailManager
  def shift(keys, offsets)
    Hash[keys.map { |k, v| [k, v + offsets[k]] }]
  end

  def key_manager(key)
    key ||= key_gen
    key = key.to_s.rjust(5, '0')
    index = 0
    %w[A B C D].reduce(Hash.new('')) do |hash, letter|
      hash[letter] = key[index..index + 1].to_i
      index += 1
      hash
    end
  end

  def date_manager(date)
    date ||= date_gen
    date = (date.to_i**2).to_s[-4..-1]
    index = 0
    %w[A B C D].reduce(Hash.new('')) do |hash, letter|
      hash[letter] = date[index].to_i
      index += 1
      hash
    end
  end

  def key_gen
    Random.new.rand(99_999)
  end

  def date_gen
    date = Time.new
    date.strftime("%d%m%y")
  end
end
