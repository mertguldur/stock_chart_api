# Stock Chart API

## Requirements

* PostgreSQL (>= 9.3)

## Installation

* `bundle install`
* `rake db:create db:migrate`
* `rake companies:import` to import the CSV data to the database.

## Running in Development

* Start the server: `rails s`.

## Running Tests

* `RAILS_ENV=test rake db:migrate`
* `cucumber`
