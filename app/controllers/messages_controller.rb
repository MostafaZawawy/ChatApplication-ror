class MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: [:index, :create, :search]
  before_action :set_message, only: [:show]

  def index
    @messages = @chat.messages
    render json: @messages
  end

  def create
    CreateMessageJob.perform_later(@chat.id, message_params[:body])
    render json: { message: 'Message creation enqueued' }, status: :accepted
  end

  def show
    render json: @message
  end

  def search
    query = params[:query]
    @messages = Message.search(query).records
    render json: @messages
  end

  private

  def set_application
    @application = Application.find_by!(token: params[:application_token])
  end

  def set_chat
    @chat = @application.chats.find_by!(number: params[:chat_number])
  end

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
