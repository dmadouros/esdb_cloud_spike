class StreamsController < ApplicationController
  def index
    @streams = Stream.all.order(created_at: :desc)
  end

  def show
    @messages = Message.where(stream: params["id"])
  end
end
