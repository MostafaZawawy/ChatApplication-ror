class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(application_id)
    application = Application.find(application_id)
    number = (application.chats.maximum(:number) || 0) + 1
    application.chats.create!(number: number)
  end
end
