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
    text
      .scan(/\d*\D{1}/)
      .map { |chunk| decode_chunk(chunk) }
      .join
  end

  def self.encode_chunk(char, chunk)
    chunk_counter = chunk.size > 1 ? chunk.size.to_s : ''
    chunk_counter + char
  end

  def self.decode_chunk(chunk)
    chunk_size = chunk.to_i
    chunk_size.zero? ? chunk.chars.last : chunk.chars.last * chunk_size
  end
end
