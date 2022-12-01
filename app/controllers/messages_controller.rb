class MessagesController < ApplicationController
  def index
    @messages = Message.all.order(timestamp: :desc)
  end

  def show
    @message = Message.find_by(event_id: params["id"])
  end
end
