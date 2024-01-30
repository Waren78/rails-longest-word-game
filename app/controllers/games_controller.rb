require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @valid = valid?(@word)
    @included = included?(@word, @letters)
    @score = @word.size
  end

  private

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = JSON.parse(URI.open(url).read)
    json['found']
  end

  def included?(word, letters)
    word.upcase.chars.all? do |letter|
      letters.include?(letter)
      letters.delete_at(letters.index(letter)) if letters.include?(letter)
    end
  end
end
