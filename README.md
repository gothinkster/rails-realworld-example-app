# ![Rails Example App](project-logo.png)

> Example Rails codebase that adheres to the [RealWorld](https://github.com/gothinkster/realworld-example-apps) API spec.

This repo is functionality complete -- PRs and issues welcome!

Check out the [rails-5.1 branch](https://github.com/gothinkster/rails-realworld-example-app/tree/rails-5.1) to see the updated code for Rails 5.1

# Getting started

To get the Rails server running locally:

- Clone this repo
- `bundle install` to install all req'd dependencies
- `rake db:migrate` to make all database migrations
- `rails s` to start the local server



# Code Overview

## Dependencies

- [acts_as_follower](https://github.com/tcocca/acts_as_follower) - For implementing followers/following
- [acts_as_taggable](https://github.com/mbleigh/acts-as-taggable-on) - For implementing tagging functionality
- [Devise](https://github.com/plataformatec/devise) - For implementing authentication
- [Jbuilder](https://github.com/rails/jbuilder) - Default JSON rendering gem that ships with Rails, used for making reusable templates for JSON output.
- [JWT](https://github.com/jwt/ruby-jwt) - For generating and validating JWTs for authentication

## Folders

- `app/models` - Contains the database models for the application where we can define methods, validations, queries, and relations to other models.
- `app/views` - Contains templates for generating the JSON output for the API
- `app/controllers` - Contains the controllers where requests are routed to their actions, where we find and manipulate our models and return them for the views to render.
- `config` - Contains configuration files for our Rails application and for our database, along with an `initializers` folder for scripts that get run on boot.
- `db` - Contains the migrations needed to create our database schema.

## Configuration

### camelCase Payloads

- [`config/initializers/jbuilder.rb`](https://github.com/gothinkster/rails-realworld-example-app/blob/master/config/initializers/jbuilder.rb) - Jbuilder configuration for camelCase output
- [`app/controllers/application_controller.rb#underscore_params!`](https://github.com/gothinkster/rails-realworld-example-app/blob/master/app/controllers/application_controller.rb#L44) - Convert camelCase params into snake_case params

### null_session

By default Ruby on Rails will throw an exception when a request doesn't contain a valid CSRF token. Since we're using JWT's to authenticate users instead of sessions, we can tell Rails to use an empty session instead of throwing an exception for requests by specifying `:null_session` in [app/controllers/application_controller.rb](https://github.com/gothinkster/rails-realworld-example-app/blob/master/app/controllers/application_controller.rb#L4).

### Authentication

Requests are authenticated using the `Authorization` header with a valid JWT. The [application_controller.rb#authenticate_user!](https://github.com/gothinkster/rails-realworld-example-app/blob/master/app/controllers/application_controller.rb#L32) filter is used like the one provided by Devise, it will respond with a 401 status code if the request requires authentication that hasn't been provided. The [application_controller.rb#authenticate_user](https://github.com/gothinkster/rails-realworld-example-app/blob/master/app/controllers/application_controller.rb#L18) filter is called on every request to try and authenticate the `Authorization` header. It will only interrupt the request if a JWT is present and invalid. The user's id is then parsed from the JWT and stored in an instance variable called [`@current_user_id`](https://github.com/gothinkster/rails-realworld-example-app/blob/master/app/controllers/application_controller.rb#L24). `@current_user_id` can be used in any controller when we only need the user's id to save a trip to the database. Otherwise, we can call [`current_user`](https://github.com/gothinkster/rails-realworld-example-app/blob/master/app/controllers/application_controller.rb#L36) to fetch the authenticated user from the database.

Devise only requires an email and password upon registration. To allow additional parameters on sign up, we use [application_controller#configure_permitted_parameters](https://github.com/gothinkster/rails-realworld-example-app/blob/master/app/controllers/application_controller.rb#L14) to allow additional parameters.

