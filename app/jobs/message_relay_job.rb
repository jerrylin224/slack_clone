class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom_id}", {
      name: message.user.name,
      body: message.body,
      created_at: message.created_at.strftime("%I:%M%p"),
      chatroom_id: message.chatroom_id
    }
  end
end
