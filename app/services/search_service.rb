# frozen_string_literal: true

class SearchService < ApplicationService
  DATA_FILE_PATH = 'data.json'

  def initialize(search_string)
    @search_string = search_string.to_s.downcase
    @search_data = load_search_data
    @exact_match_values, @positive_values, @negative_values = parse_search_string
  end

  def call
    return @search_data if @search_string.blank?

    matched_data = @search_data.select do |data|
      data_values_string = data.values.join(' ')
      matches_positive_query?(data, data_values_string) &&
        matches_negative_query?(data_values_string) &&
        matches_exact_query?(data_values_string)
    end

    matched_data.sort_by! { |hash| hash['times'] }.reverse
  end

  private

  # Parses JSON data from file
  def load_search_data
    JSON.parse(File.read(DATA_FILE_PATH))
  end

  # Parses the search string to sort it into exact, positive, and negative
  # Returns arrays of exact matches, positive matches, and negative matches without the prefix "-"
  def parse_search_string
    exact_matches = @search_string.scan(/"([^"]+)"/).flatten        # Find all exact matches in quotes
    remaining_string = @search_string.gsub(/"([^"]+)"/, '')         # Remove exact match queries from the search string
    positive, negative = # Split the remaining string into positive and negative matches based on prefix
      remaining_string.split.partition do |v|
      !v.start_with?('-')
    end
    [exact_matches, positive, negative.map { |v| v.delete_prefix('-') }]
  end

  # Check if any of the positive match values are included in the data string
  # Initial version of match counter to sort by relevance
  def matches_positive_query?(data, data_values_string)
    return true if @positive_values.blank?

    data['times'] = 0
    @positive_values.each do |string|
      data['times'] += 1 if data_values_string.downcase.include?(string)
    end

    data['times'] != 0
  end

  # Checks if none of the negative match values are included in the data string
  def matches_negative_query?(data_values_string)
    @negative_values.none? { |string| data_values_string.downcase.include?(string) }
  end

  # Checks if the data string has any of the exact match values
  def matches_exact_query?(data_values_string)
    return true if @exact_match_values.blank?

    @exact_match_values.any? do |string|
      data_values_string.match?(/\b#{Regexp.escape(string)}\b/i)
    end
  end
end
