require 'prime'
class Raindrops
  def self.convert(number)
    found = "" 
    convert = {3 => "Pling", 5 => "Plang", 7 => "Plong"}
    factors = Prime.prime_division(number)
    factors.each do |factor|
      if convert.key?(factor[0])
       found << convert[factor[0]]
      end
    end
    if found.length > 0
      puts found
      return found
    else
      puts number.to_s
      number.to_s
    end
  end
end
