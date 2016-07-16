module BookKeeping
  VERSION = 1
end

class Game
  attr_reader :frames

  def initialize
    @frames = [Frame.new]
  end

  def roll(num)
    raise 'Pins must have a value from 0 to 10' unless (0..10).cover? num
    raise 'Pin count exceeds pins on the lane' unless (0..10).cover?(current_frame.score + num) || last_frame?
    raise 'Pin count exceeds pins on the lane' if last_frame? && (current_frame.score + num) > 20 && current_frame.score != 20
    raise 'Should not be able to roll after game is over' if finished?

    current_frame.roll(num)

    if previous_frame && !extra_ball?
      previous_frame.add_score(num) if previous_frame.strike?
      previous_frame.add_score(num) if previous_frame.spare? && current_frame.first_roll?
      frames[-3].add_score(num) if multiple_strikes?
    end

    frames.push(Frame.new) if current_frame.finished? && !last_frame?
  end

  def score
    raise 'Score cannot be taken until the end of the game' unless finished?

    frames.inject(0) { |sum, frame| sum + frame.score }
  end

  private

  def current_frame
    frames.last
  end

  def previous_frame
    frames[-2]
  end

  def last_frame?
    frames.size == 10
  end

  def extra_ball?
    last_frame? && current_frame.fill_ball?
  end

  def multiple_strikes?
    frames[-3] && frames[-3].strike? && previous_frame.strike? && current_frame.first_roll?
  end

  def finished?
    last_frame? && ((current_frame.score < 10 && current_frame.rolls == 2) || current_frame.rolls == 3 )
  end
end

class Frame
  attr_reader :score, :rolls

  MAX_POINTS = 10
  MAX_ROLLS = 2

  def initialize()
    @score = 0
    @rolls = 0
  end

  def roll(num)
    @rolls += 1
    @score += num
  end

  def add_score(num)
    @score += num
  end

  def first_roll?
    @rolls == 1
  end

  def fill_ball?
    @rolls == 3 || @rolls == 2 && score == 10
  end

  def finished?
    score >= MAX_POINTS || rolls == MAX_ROLLS
  end

  def strike?
    rolls == 1 && finished?
  end

  def spare?
    rolls == 2 && score >= MAX_POINTS
  end
end