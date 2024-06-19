class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: [:show]

  def index
    @chats = @application.chats
    render json: @chats
  end

  def create
    CreateChatJob.perform_later(@application.id)
    render json: { message: 'Chat creation enqueued' }, status: :accepted
  end

  def show
    render json: @chat
  end

  private

  def set_application
    @application = Application.find_by!(token: params[:application_token])
  end

  def set_chat
    @chat = @application.chats.find_by!(number: params[:number])
  end
end
