class Translation

  CODON_PROTEIN = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  def self.of_codon(codon)
    CODON_PROTEIN.fetch(codon) { raise InvalidCodonError }
  end

  def self.of_rna(rna)
    translations(rna).take_while { |res| res !=  "STOP" }
  end

  private

  def self.translations(rna)
    rna.chars.each_slice(3).map{ |codon| of_codon(codon.join) }
  end

end

class InvalidCodonError < StandardError; end
