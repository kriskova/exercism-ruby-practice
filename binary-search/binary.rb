class BinarySearch
  attr_reader :list

  def initialize(list)
    raise ArgumentError if list != list.sort
    @list = list 
    @pos = 0
  end

  def search_for(item)
    raise RuntimeError if !@list.include?(item)

    return @pos + middle if @list[middle] == item
    if @list[middle] < item
      @pos += middle
      @list = @list.drop(middle)
      search_for(item)
    else
      @list = @list.take(middle)
      search_for(item)
    end
  end

  def middle
    @list.size / 2
  end
end