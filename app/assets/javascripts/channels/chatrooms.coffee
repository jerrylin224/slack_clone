App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
    if active_chatroom.length > 0

      if document.hidden
        if $(".strike").length == 0
          active_chatroom.append("<div class='strike'><span>Unread Messages</span></div>")

        if Notification.permission == "granted"
          new Notification(data.name, {body: data.body})

      else
        App.last_read.update(data.chatroom_id)

      # Insert the message
      active_chatroom.append("<div><strong>#{data.name}:</strong> #{data.body} #{data.created_at}</div>")

    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")

  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}