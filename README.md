# README

SearchApp is a Ruby application for performing complex search. 
It filters search data based on exact, positive, and negative match criteria provided through a search bar.

## Features

- Case-insensitive search.
- Supports exact match searches enclosed within quotes.
- Allows positive searches (default matches).
- Enables negative searches with a - prefix to exclude certain words.
- Sorts matched data based on the number of matches.

<img width="801" alt="Знімок екрана 2024-01-10 о 17 02 04" src="https://github.com/JuliaKovtun/search_app/assets/26040954/cd6e5542-90d1-463f-ab4a-6a0e17f3a0ba">

  
<img width="1432" alt="Знімок екрана 2024-01-10 о 17 03 35" src="https://github.com/JuliaKovtun/search_app/assets/26040954/dfe8f17c-696d-4fb8-bce4-208edc60fa88">

<img width="1409" alt="Знімок екрана 2024-01-10 о 17 04 39" src="https://github.com/JuliaKovtun/search_app/assets/26040954/bb221f4c-8817-42d2-a12f-3c0985bd87ef">


* Ruby version: 3.3.0

* Rails version: 7.1.2

## Configuration

To get started with SearchApp, clone the repository and install the required gems:

```bash
git clone https://github.com/JuliaKovtun/search_app.git
cd search-app
bundle install
```

## How to run the test suite

```bash
bin/bundle exec rspec
```
