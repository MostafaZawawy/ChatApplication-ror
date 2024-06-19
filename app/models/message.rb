class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: true

  validates :number, presence: true, uniqueness: { scope: :chat_id }

  before_validation :set_number, on: :create

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :body, type: :text, analyzer: 'english'
    end
  end

  private

  def set_number
    self.number = (chat.messages.maximum(:number) || 0) + 1
  end
end
