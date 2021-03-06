class Nucleotide

  def self.from_dna(dna)
    Nucleotide.new(dna)
  end

  def initialize(dna)
    @dna = dna
    @histogram = {"A" => 0, "T" => 0, "C" => 0, "G" => 0}
    @histogram.default = 0

    raise ArgumentError unless @dna.chars.all?{|x| @histogram.keys.include?(x)}
  end

  def count(nucleotide)
    @dna.chars.count(nucleotide)
  end

  def histogram
    @dna.chars.each{|nuc| @histogram[nuc] += 1}
    @histogram
  end

end