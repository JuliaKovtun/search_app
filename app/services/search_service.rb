# frozen_string_literal: true

class SearchService < ApplicationService

  def initialize(search_string, search_data)
    @search_string = search_string.downcase
    @search_data = search_data
    @exact_match_values, @positive_values, @negative_values = parse_search_string
  end

  def call
    matched_data = @search_data.select do |data|
      data_values_string = data.values.join(' ')
      matches_positive_query?(data_values_string) && 
      matches_negative_query?(data_values_string) &&
      matches_exact_query?(data_values_string)
    end

    matched_data
  end

  private
  
  def parse_search_string
    exact_matches = @search_string.scan(/"([^"]+)"/).flatten
    remaining_string = @search_string.gsub(/"([^"]+)"/, '')
    positive, negative = remaining_string.split.partition { |v| !v.start_with?('-') }
    [exact_matches, positive, negative.map { |v| v.delete_prefix('-') }]
  end

  def matches_positive_query?(data_values_string)
    @positive_values.any? do |string|
      data_values_string.downcase.include?(string)
    end
  end

  def matches_negative_query?(data_values_string)
    @negative_values.none? { |string| data_values_string.downcase.include?(string) }
  end

  def matches_exact_query?(data_values_string)
    @exact_match_values.none? do |string|
      data_values_string.match(/\b#{Regexp.escape(string)}\b/i).nil?
    end
  end
end
