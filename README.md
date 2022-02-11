# Spending Tracker

*A spending tracker (Skint) which allows a user to organise spending and track against a budget. First solo CodeClan project. Ruby/Sinatra backend with a PostreSQL database, HTML5 and vanilla CSS used for the frontend. MVC architecture.*

![Profile Screenshot](/screenshots/home.png)

## Features

* Set a budget and warning limit to notify the user when it is reached

* Add and manage transactions, merchants and tags

* Filter transactions by merchant, tag or month


## Screenshots

#### View all transactions
![All transactions](/screenshots/transactions.png)

#### Add budget
![Add Budget](/screenshots/add_budget.png)

#### Budget warning
![Budget warning](/screenshots/budget_warning.png)

#### Filtering overview
![Filtering Overview](/screenshots/filtering.png)


### Prerequisites

In order to run the application locally you will need the following software installed on your machine -

* [Sinatra](http://sinatrarb.com/)
* [Ruby](https://www.ruby-lang.org/en/)
* [PG Gem](https://rubygems.org/gems/pg/versions/0.18.4)
* [PostreSQL](https://www.postgresql.org/)
* [Pry](https://rubygems.org/gems/pry/versions/0.10.3)


## Installation

Here's how you can get the Skint running locally once you download the repository. This will need to be done from the root of the local repository folder.

Create the database

```
createdb spending_tracker
```

Run database schema

```
psql -d spending_tracker -f db/spending_tracker.sql
```

Run seed file for creation of initial transactions, merchants and tags

```
ruby db/seeds.rb
```

Launch app

```
ruby app.rb
```

Once completed go to http://localhost:4567 in your browser to view the app.
