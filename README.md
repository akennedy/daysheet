# Welcome to DaySheet

DaySheet is a timesheet that simply keeps up with days worked instead of time worked and will eventually allow you to create daysheets to print or email.
This project is just beginning with little to no functionality yet

Getting DaySheet up and running on your system.

### Requirements

- Ruby 1.8.7 or 1.9.2 - [www.ruby-lang.org](http://www.ruby-lang.org)

    rvm highly recommended to manage your ruby versions - [rvm.beginrescueend.com](http://rvm.beginrescueend.com/)
- Rubygems 1.3.7 - [www.rubygems.org](http://www.rubygems.org)
- Rake 0.8.7
    
    gem install rake
    
- Bundler 1.0.7
  
    gem install bundler

- MySQL 

  Install on Snow Leopard with Homebrew
  
[http://solutions.treypiepmeier.com/2010/02/28/installing-mysql-on-snow-leopard-using-homebrew/](http://solutions.treypiepmeier.com/2010/02/28/installing-mysql-on-snow-leopard-using-homebrew/)

- Git

    brew install git
    
- Node

    brew install node
    
- CoffeeScript

    brew install npm
    
    npm install coffee-script

## Git The Code

    $ git clone https://akennedy@github.com/akennedy/daysheet.git
    $ cd daysheet

## Install Gems

    $ gem install bundler
    $ bundle install

## Set Up The Database

DaySheet supports MySQL and SQLite databases. The source code comes with
two sample database configuration files: config/database.mysql.yml
for MySQL and config/database.sqlite.yml for SQLite. Based on your choice
of the database create the actual database configuration file, for example:

    $ cp config/database.mysql.yml config/database.yml

Edit config/database.yml and specify database names and authentication
details. Once you have database configuration file ready run rake to create
the database:

    $ rake db:create


## Set Up The App

The next step is to load default DaySheet settings, such as menu structures
and create the Admin user. This is done by running the
following rake task:

    $ rake daysheet:setup

## Run The App

Now you should be able to launch the Rails server and point your web browser
to http://localhost:3000

    $ rails s
   
## TODO

Need to create TODO list.



