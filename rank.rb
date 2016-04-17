class Rank
  include Comparable
  attr_accessor :member, :score

  def initialize(member, score)
    @member = member
    @score = score
  end
end