class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id, body)
    chat = Chat.find(chat_id)
    number = (chat.messages.maximum(:number) || 0) + 1
    chat.messages.create!(number: number, body: body)
  end
end
