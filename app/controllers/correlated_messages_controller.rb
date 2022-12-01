class CorrelatedMessagesController < ApplicationController
  def show
    @messages = Message.where(trace_id: params["id"]).order(timestamp: :asc)
  end
end
