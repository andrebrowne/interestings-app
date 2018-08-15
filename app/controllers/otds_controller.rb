require 'json'
class OtdsController < ApplicationController
  before_action :set_otd, only: :show

  # GET /otds
  # GET /otds.json
  def index
    @wiki_fact = Wikipedia.find(DateTime.now.strftime("%B %e"))
    @wiki_raw = @wiki_fact.text
    @wiki_events = @wiki_raw.split("\n")
    @wiki_events_filtered = []

    on_this_day = {
      "== Events ==" => [],
      "== Births ==" => [],
      "== Deaths ==" => [],
      "== Holidays and observances ==" => [],
      "== References ==" => [],
      "== External links ==" => []
    }

    current_section = nil
    @wiki_events.each do |event|
      if event.strip.length.zero?
        next
      end
      if event.strip.start_with?('==')
        current_section = event.strip
        next
      end
      if current_section.nil?
        next
      end
      on_this_day[current_section].push(event)
    end
    @facts_of_the_day_events = on_this_day["== Events =="].sample(5).sort_by { |x| x[/\d+/].to_i }
    @facts_of_the_day_births = on_this_day["== Births =="].sample(5).sort_by { |x| x[/\d+/].to_i }
    @facts_of_the_day_holidays = on_this_day["== Holidays and observances =="].sample(5).sort
  end
end
