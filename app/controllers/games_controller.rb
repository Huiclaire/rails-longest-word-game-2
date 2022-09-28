require 'open-uri'

class GamesController < ApplicationController
  VOWELS = %W[A E I O U Y]

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  # word.chars.all? { ... } will return a true or false
  # -> https://apidock.com/ruby/Enumerable/all%3F

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # reading the file
    response = URI.open(url).read
    # once the file is loaded, we can parse the JSON information using JSON.paerse method
    json = JSON.parse(response)
    # once the file parsed into ruby hash, we can use buil-in methods to manipulate the values.
    json['found']
  end
end
