# README

SearchApp is a Ruby application for performing complex search. 
It filters search data based on exact, positive, and negative match criteria provided through a search bar.

## Features

- Case-insensitive search.
- Supports exact match searches enclosed within quotes.
- Allows positive searches (default matches).
- Enables negative searches with a - prefix to exclude certain words.
- Sorts matched data based on the number of matches.

<img width="1440" alt="Знімок екрана 2024-01-11 о 16 25 47" src="https://github.com/JuliaKovtun/search_app/assets/26040954/936e0545-1072-478c-a9ef-d08ad8c8a3ae">

<img width="1440" alt="Знімок екрана 2024-01-11 о 16 26 51" src="https://github.com/JuliaKovtun/search_app/assets/26040954/6764112e-d11b-41b5-9733-74d840a383ca">

<img width="1440" alt="Знімок екрана 2024-01-11 о 16 27 30" src="https://github.com/JuliaKovtun/search_app/assets/26040954/bf6466f2-0948-4230-a833-1cbee8d349ce">

* Ruby version: 3.3.0

* Rails version: 7.1.2

## Configuration

To get started with SearchApp, clone the repository and install the required gems:

```bash
git clone https://github.com/JuliaKovtun/search_app.git
cd search-app
bundle install
./bin/dev
```

## How to run the test suite

```bash
bin/bundle exec rspec
```
