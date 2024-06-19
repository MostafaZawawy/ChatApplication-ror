class Application < ApplicationRecord
  has_many :chats, dependent: :destroy
  validates :name, presence: true
  validates :token, presence: true, uniqueness: true

  after_commit :update_chats_count, on: [:create, :destroy]


  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = SecureRandom.hex(10) if self.token.blank?
  end

  def update_chats_count
    UpdateChatsCountJob.perform_later(id)
  end
end
