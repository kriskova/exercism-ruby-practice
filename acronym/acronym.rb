class Acronym

  VERSION = 1
  FIRST_CHAR = ->(word) { word[0] }

  def self.abbreviate(string)
    words(string).map(&FIRST_CHAR).join.upcase
  end

  private

  def self.words(string)
    string.split(/[\s-]|[a-z](?=[A-Z])/)
  end

end
