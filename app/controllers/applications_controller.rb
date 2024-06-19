class ApplicationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @applications = Application.all
    render json: @applications
  end

  def create
    @application = Application.new(application_params)
    @application.token = SecureRandom.hex(10) if @application.token.blank?

    if @application.save
      render json: { token: @application.token, name: @application.name }, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def show
    @application = Application.find_by!(token: params[:token])
      render json: @application
  end
  

  private

  def application_params
    params.require(:application).permit(:name)
  end
end
