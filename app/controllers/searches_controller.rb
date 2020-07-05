class SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    if @range == '1'
      @user = search_user(search,word)
    elsif @range == '2'
      @book = search_book(search,word)
    elsif @range == '0'
      redirect_back(fallback_location: root_path)
      flash[:notice] = "「User」か「Book」を選んでください。"
    end
  end

  private

  def search_user(search,word)
    if search == "forward_match"
      User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      User.where("#{word}")
    elsif search == "partial_match"
      User.where("name LIKE?","%#{word}%")
    else
      User.all
    end
  end

  def search_book(search,word)
    if search == "forward_match"
      Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
      Book.where("#{word}")
    elsif search == "partial_match"
      Book.where("title LIKE?","%#{word}%")
    else
      Book.all
    end
  end

end
