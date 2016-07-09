module BookKeeping
  VERSION = 2
end

class RunLengthEncoding

  def self.encode(text)
    text
      .chars
      .chunk { |c| c }
      .map { |char, chunk| encode_chunk(char, chunk) }
      .join
  end

  def self.decode(text)
    text.gsub(/\d+./) { |str| str[-1] * str.to_i }
  end

  def self.encode_chunk(char, chunk)
    chunk_counter = chunk.size > 1 ? chunk.size.to_s : ''
    chunk_counter + char
  end
end
