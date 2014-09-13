class Say

  VALUES = {
    1_000_000_000 => "billion",
    1000000 => "million",
    1000 => "thousand",
    100 => "hundred",
    90 => "ninety",
    80 => "eighty",
    70 => "seventy",
    60 => "sixty",
    50 => "fifty",
    40 => "forty",
    30 => "thirty",
    20 => "twenty",
    19 => "nineteen",
    18 => "eighteen",
    17 => "seventeen",
    16 => "sixteen",
    15 => "fifteen",
    14 => "fourteen",
    13 => "thirteen",
    12 => "twelve",
    11 => "eleven",
    10 => "ten",
    9 => "nine",
    8 => "eight",
    7 => "seven",
    6 => "six",
    5 => "five",
    4 => "four",
    3 => "three",
    2 => "two",
    1 => "one"
  }

  def initialize(num)
    @num = num
  end

  def in_english
    chunks = chunk_to_thousands(@num)
    chunks.inject("") do |result, part|
      result << translate_part(part.to_i * position_value(part, chunks))
    end
  end

  private

  def position_value(part, array)
    10 ** (array.length - array.index(part) + 1)
  end

  def chunk_to_thousands(num)
    num.to_s.chars.reverse.each_slice(3).map(&:reverse).map(&:join).reverse
  end

  def translate_part(num)
    return "zero" if num == 0

    remaining = num
    previous_element = 0
    VALUES.inject("") do |result, (key, value)|
      if remaining >= key
        counter = remaining / key
        
        case
        when key >= 100
          result << " " unless result.empty?
          result << "#{VALUES[counter]} #{value}"
        when key.between?(10,99)
          result << " " unless result.empty?
          result << value
        when key < 10
          if previous_element >= 100
            result << " "
          else
            result << "-" unless result.empty?
          end
          result << value
        end
        remaining = remaining - counter * key
        previous_element = key
      end
      result
    end
  end
end
