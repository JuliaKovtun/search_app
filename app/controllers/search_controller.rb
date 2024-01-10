# frozen_string_literal: true

class SearchController < ApplicationController
  
  def search
    search_data = JSON.parse(File.read('data.json'))

    @data = params[:search].present? ? SearchService.call(search_params['search'], search_data) : search_data
  end

  private

  def search_params
    params.permit(:search)
  end
end
