require 'byebug'

module BookKeeping
  VERSION = 1
end

class Game
  attr_reader :frames

  def initialize
    @frames = [Frame.new]
  end

  def roll(pins)
    raise 'Pins must have a value from 0 to 10' unless (0..10).cover? pins
    raise 'Should not be able to roll after game is over' if finished?

    current_frame.roll(pins)

    add_extra_scores(pins)

    start_new_frame if current_frame.finished? && !last_frame?
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

  def frame_before_previous
    frames[-3]
  end

  def last_frame?
    frames.size == 10
  end

  def multiple_strikes?
    frame_before_previous && frame_before_previous.strike? && previous_frame.strike?
  end

  def finished?
    last_frame? && current_frame.finished?
  end

  def start_new_frame
    new_frame = last_frame_next? ? TenthFrame.new : Frame.new

    frames.push(new_frame) 
  end

  def last_frame_next?
    frames.size == 9
  end

  def add_extra_scores(pins)
    return unless previous_frame && !current_frame.fill_ball?

    previous_frame.add_score(pins) if previous_frame.strike?

    return unless current_frame.first_roll?

    previous_frame.add_score(pins) if previous_frame.spare?
    frame_before_previous.add_score(pins) if multiple_strikes?
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

  def roll(pins)
    raise 'Pin count exceeds pins on the lane' unless (0..10).cover?(score + pins)

    @rolls += 1
    @score += pins
  end

  def add_score(pins)
    @score += pins
  end

  def first_roll?
    @rolls == 1
  end

  def fill_ball?
    false
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

class TenthFrame < Frame
  MAX_POINTS = 30
  MAX_ROLLS = 3

  def roll(pins)
    raise 'Pin count exceeds pins on the lane' if (score + pins) > 20 && score != 20
    
    @rolls += 1
    @score += pins
  end

  def fill_ball?
    @rolls == MAX_ROLLS 
  end

  def finished?
    (score < 10 && rolls == 2) || rolls == MAX_ROLLS
  end
end