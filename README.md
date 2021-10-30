# Weather App

This app tells the user whether today's going to be **Cold**, **Warm**, or **Hot** based on the user's definitions of the temperature ranges and a given postal code.

Presently, only UK postal codes are accepted.

## Setup

Requires `docker` & `docker-compose` to be installed.

1. Build the app:
```bash
docker-compose build
```
2. Install the gems:
```bash
docker-compose run web bundle install
```
3. Create the `.env` file used in development; edit the vars as needed:
```bash
cp .env.example .env
```
4. Create the `.env.test` file used in tests; replace `weather_app_dev` with `weather_app_test` and edit the rest as needed:
```bash
cp .env.example .env.test
```
5. Create the development database:
```bash
docker-compose run web bundle exec rails db:prepare
```
6. Prepare the test database:
```bash
docker-compose run web bundle exec rails db:test:prepare
```
7. Start the app
```bash
docker-compose up
```

## Testing

Tests can be ran on file change using `guard`; pressing <kbd>ENTER</kbd> while in `guard` will run all tools defined in the `Guardfile`:

```bash
docker-compose run web bundle exec guard
```

Alternatively, replace `guard` with `rspec` or `rubocop` to run the specs or the linter individually.