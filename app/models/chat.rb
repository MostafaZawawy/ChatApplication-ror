class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy

  after_commit :update_messages_count, on: [:create, :destroy]

  validates :number, presence: true, uniqueness: { scope: :application_id }

  before_validation :set_number, on: :create

  private

  def set_number
    self.number = (application.chats.maximum(:number) || 0) + 1
  end

  def update_messages_count
    UpdateMessagesCountJob.perform_later(id)
  end
end
