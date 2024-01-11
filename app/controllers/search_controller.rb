# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    @data = SearchService.call(search_params['search'])
  end

  private

  def search_params
    params.permit(:search)
  end
end
