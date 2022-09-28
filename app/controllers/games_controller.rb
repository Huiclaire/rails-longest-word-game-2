class GamesController < ApplicationController
  VOWELS = %W[A E I O U Y]

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    raise
  end
end
