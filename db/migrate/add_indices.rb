class AddIndices < ActiveRecord::Migration[7.1]
    def change
      add_index :applications, :token, unique: true
      add_index :chats, :number
      add_index :chats, :application_id
      add_index :messages, :number
      add_index :messages, :chat_id
    end
  end
  