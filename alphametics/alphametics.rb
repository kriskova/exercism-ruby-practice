class Alphametics
  attr_reader :chars, :text

  def solve(text)
    @text = text

    permutations.each do |perm|
      equation = generate_equation(perm)
      next if invalid_equation?(equation)

      return Hash[chars.zip(perm)] if eval equation
    end

    nil
  end

  private

  def chars
    @chars ||= text.scan(/[A-Z]/).uniq.sort
  end

  def generate_equation(nums)
    normalize_operators(text.tr(chars.join, nums.join))
  end

  def invalid_equation?(equation)
    equation.scan(/\d+/).any? { |num| num.length > 1 && num.start_with?('0') }
  end

  def normalize_operators(equation)
    equation.gsub('^','**')
  end

  def permutations
    (0..9).to_a.permutation(chars.size)
  end
end

module BookKeeping
  VERSION = 2
end
