class UpdateChatsCountJob < ApplicationJob
    queue_as :default
  
    def perform(application_id)
      application = Application.find(application_id)
      application.update_column(:chats_count, application.chats.count)
    end
  end
  