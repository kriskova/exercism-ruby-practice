module BookKeeping
  VERSION = 2
end

class Pangram
  include BookKeeping

  ALPHABET = ('a'..'z').to_a

  def self.is_pangram?(sentence)
    (ALPHABET - chars_in_sentence(sentence.downcase)).empty?
  end

  private

  def self.chars_in_sentence(sentence)
    sentence.scan(/\w/)
  end
end