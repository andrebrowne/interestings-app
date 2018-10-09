require 'json'

class OtdsController < ApplicationController
  include WikipediaPageHelper
  before_action :set_otd, only: :show

  # GET /otds
  # GET /otds.json
  def index
    @interestings = getOnThisDayInterestings()
  end
end
