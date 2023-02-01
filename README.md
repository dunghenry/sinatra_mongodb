# Sinatra + MongoDB

## Setup project

### Create Gemfile

```js
source 'https://rubygems.org'
gem 'sinatra', '~> 2.0'
gem 'mongoid', '~> 7.0'
```

### Install dependencies

```js
gem install bundler
bundle install
```

### Config MongoDB local

```js
development:
  clients:
    default:
      database: database_name
      hosts:
        - localhost:27017
      options:
        server_selection_timeout: 1
```

### Config MongoDB Atlas

```js
development:
  clients:
    default:
      uri: mongodb+srv://username:passsword@yourcluster.mongodb.net/database_name?retryWrites=true&w=majority
      options:
        server_selection_timeout: 5
```

### Start server

```js
ruby main.rb
```
