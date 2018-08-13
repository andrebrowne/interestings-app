require 'json'
class OtdsController < ApplicationController
  before_action :set_otd, only: [:show, :edit, :update, :destroy]

  # GET /otds
  # GET /otds.json
  def index
    @wiki_fact = Wikipedia.find(DateTime.now.strftime("%B %e"))
    @wiki_raw = @wiki_fact.text
    @wiki_events = @wiki_raw.split("\n") #creates an array
    @facts_of_the_day = @wiki_events.slice!(20,5)
    @wiki_events = @facts_of_the_day
  end
end
