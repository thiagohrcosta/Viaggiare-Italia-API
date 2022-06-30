class Api::V1::PlacesController < Api::V1::BaseController
  before_action :set_place, only: [:show]

  def index
    @places = policy_scope(Place)
  end

  def show
  end

  private

  def set_place
    @place = Place.find(params[:id])
    authorize @place
  end
end
