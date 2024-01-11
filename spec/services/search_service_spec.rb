# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService, type: :service do
  subject(:search_service) { described_class.new(search_string).call }

  context 'basic search' do
    context 'when language exists' do
      let(:search_string) { 'Lisp Common' }

      it 'finds programming language' do
        expect(search_service[0].values).to include('Common Lisp')
      end
    end

    context 'when language does not exist' do
      let(:search_string) { 'some name' }

      it 'does not find programming language' do
        expect(search_service).to eq([])
      end
    end
  end

  context 'negative search' do
    context 'with one negative search argument' do
      let(:search_string) { 'john -array' }

      it 'returns searched programming languages' do
        expect(search_service.map { |hash| hash['Name'] }).to include('BASIC', 'Haskell', 'Lisp', 'S-Lang')
      end

      it 'does not return excluded programming languages' do
        expect(search_service.map { |hash| hash['Name'] }).not_to include('Chapel', 'Fortran', 'S')
      end
    end

    context 'with multiple negative search arguments' do
      let(:search_string) { 'john -array -Thomas' }

      it 'returns searched programming languages' do
        expect(search_service.map { |hash| hash['Name'] }).to include('Lisp', 'S-Lang')
      end

      it 'does not return excluded programming languages' do
        expect(search_service.map { |hash| hash['Name'] }).not_to include('BASIC', 'Haskell', 'Chapel', 'Fortran', 'S')
      end
    end
  end

  context 'exact search' do
    context 'when searched data exists' do
      let(:search_string) { '"Object-oriented class-based"' }

      it 'returns searched programming languages' do
        result = search_service
        expect(result.length).to eq(36)
        expect(result.map { |hash| hash['Name'] }).to include('ActionScript', 'Ada', 'Blue')
      end

      it 'does not return programming languages without data' do
        expect(search_service.map { |hash| hash['Name'] }).not_to include('R', 'S-Lang')
      end
    end

    context 'when searched data does not exist' do
      let(:search_string) { '"exact searched string"' }

      it 'returns an empty array' do
        expect(search_service).to eq([])
      end
    end
  end
end
