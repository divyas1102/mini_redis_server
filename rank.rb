class Rank
  include Comparable
  attr_accessor :member, :score

  def initialize(member, score)
    @member = member
    @score = score
  end

  def ==(another_rank)
    self.score == another_rank.score
  end

  def <=>(another_rank)
    if self.score < another_rank.score
      -1
    elsif self.score > another_rank.score
      1
    else
      0
    end
  end

end