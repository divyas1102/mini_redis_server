require 'set'
require_relative 'rank'

class Sortedset
  include Comparable

  @my_z_set = Hash.new #structure: {'key': <Set>[Rank{member: 'x', score: '1'}, Rank{member: 'y', score: '2'}]}

  def self.add_value(key, score, member)
    count = 0
    begin
      if @my_z_set.include?(key)
        @my_z_set[key].add(Rank.new(member, score))
      else
        @my_z_set[key] = SortedSet.new [Rank.new(member, score)]
      end
      count = count + 1
    rescue => e
      e.inspect
    end
    count #returns number of rows updated. current implementation will only allow one.
  end

  def self.get_cardinality(key) # number of elements in the sorted set stored at key
    @my_z_set[key].length
  end

  def self.get_rank(key, member)
    if @my_z_set.include?(key)
      @my_z_set[key].each_with_index do |rank, index|
        if rank.member == member
          return index
        end
      end
      'MEMBER NOT FOUND'
    else
      'KEY NOT FOUND'
    end
  end
end
