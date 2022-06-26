class Api::V1::DestinationsController < Api::V1::BaseController
  before_action :set_destination, only: [:show, :update, :destroy]

  def index
    @destinations = policy_scope(Destination)
    authorize @destinations
  end

  def show
  end

  private

  def set_destination
    @destination = Destination.find(params[:id])
    authorize @destination
  end

  def destination_params
    params.require(:destination).permit(:name, :region, :photo, :banner)
  end
end
