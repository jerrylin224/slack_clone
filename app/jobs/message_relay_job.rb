class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom_id}", {
      body: message.body,
      chatroom_id: message.chatroom_id
    }
  end
end
