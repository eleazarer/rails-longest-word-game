require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split(' ')
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @valid_word = valid_word?(@word)

    if @included && @valid_word
      @message = "Congratulations! #{@word} is a valid English word."
      session[:score] ||= 0
      session[:score] += @word.length
    elsif @included
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @message = "Sorry but #{@word} can't be built out of #{@letters.join(', ')}"
    end
    @total_score = session[:score]
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def valid_word?(word)
    response = URI.open("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
    json = JSON.parse(response.read)
    !json['title'].present?
  rescue OpenURI::HTTPError
    false
  end
end
