# Weather App

This app tells the user whether today's going to be **Cold**, **Warm**, or **Hot** based on the user's definitions of the temperature ranges and a given postal code.

Presently, only UK postal codes are accepted.

## Setup

Requires `docker` & `docker-compose` to be installed.

1. `docker-compose build` to build the app.
2. `docker-compose run web bundle install` to install the gems.
3. `cp .env.example .env` and edit fields as needed.
4. `cp .env.example .env.test` and edit the ENV variables used in tests as needed. Replace `weather_app_dev` with `weather_app_test`.
5. `docker-compose run web bundle exec rails db:prepare` to setup the database.
6. `docker-compose up` to start the app.

## Testing

Tests can be ran on file change using `guard`; pressing <kbd>ENTER</kbd> while in `guard` will run all tools defined in the `Guardfile`:

```bash
docker-compose run web bundle exec guard
```

Alternatively, replace `guard` with `rspec` or `rubocop` to run the specs or the linter individually.