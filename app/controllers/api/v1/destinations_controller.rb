class Api::V1::DestinationsController < Api::V1::BaseController

  def index
    @destinations = policy_scope(Destination)
    authorize @destinations
  end
end
