class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order(created_at: :desc)
  end

  def show
    like_clause = "#{params["id"]}-%"
    @messages = Message.where("stream like ? ", like_clause)
  end
end
