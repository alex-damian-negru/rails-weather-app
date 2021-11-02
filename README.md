# Weather App

This app tells the user whether today's going to be **Cold**, **Warm**, or **Hot** based on the user's definitions of the temperature ranges and a given postal code.

Presently, only UK postal codes are accepted.

## Setup

### Dockerized version
Requires `docker` & `docker-compose` to be installed.

1. Build the app:
```bash
docker-compose build
```
2. Copy the env variables
```bash
cp .env.example .env
cp .env.example .env.test
```
3. Install the gems:
```bash
docker-compose run web bundle install -j4
```
4. Start the app
```bash
docker-compose up
```

### Local version

Requirements:
- ruby-3.0.2
- bundler

1. Install required gems
```bash
bundle install -j4
```

2. Copy the env variables
```bash
cp .env.example .env
cp .env.example .env.test
```

3. Start the app
```bash
bundle exec rails server
```

---

Access the app on `localhost:3000`.

## Testing

Tests can be ran on file change using `guard`; pressing <kbd>ENTER</kbd> while in `guard` will run all tools defined in the `Guardfile`:

```bash
docker-compose run web bundle exec guard
```

or

```bash
bundle exec guard
```

Alternatively, replace `guard` with `rspec` or `rubocop` to run the specs or the linter individually.