require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters.push(('A'..'Z').to_a.sample) }
  end

  def score
    @word = params[:word]

    word = @word.chars
    @grid = params[:letters].split(" ")
    @answer = ""
  
    data = JSON.parse(URI("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    if data["found"]
      word_in_grid = word.all? { |char| word.count { |el| el == char } <= @grid.count { |el| el == char.upcase } }
      if word_in_grid
        @answer = "in grid"
      else
        @answer = "not grid"
      end
    else
      @answer = "not english"
    end
  end
end
