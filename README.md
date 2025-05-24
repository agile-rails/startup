# AgileRails startup application

How to install startup application?

Instructions are Ubuntu/Debian specific, but there should be no problem to deploy 
them on any operating system where Ruby interpreter is available. 

### Requirements:

Ruby version: >= 3.2, Rails >= 7.2
  
### System dependencies:
```bash
# minimal application requirements 
sudo apt install ruby git sqlite3 nodejs
# some ruby gems may require a compilation
sudo apt install build-essential ruby-dev libyaml-dev
# install Ruby on Rails
sudo gem install bundler rails
# if there are problems reading YAML files 
sudo gem update psych
```

### Configuration
```bash
# change to your applications root directory
cd /.../your_apps_home_directory
# clone AgileRails startup application from github
git clone https://github.com/agile-rails/startup.git your_app_directory
# change to application root
cd  your_app_directory
# install required gems
bundle install
```

### Database creation and initialization

Before the application is started, database must be created and loaded with some data and default admin user must be created.
```bash
rails agile:db:migrate
rails agile:seed_load
```

### Run server

Run application in development mode.
```bash
rails server
```

Start browser and go to url http://localhost:3000

Login with credentials provided in database creation step.

Congratulations. If everything went OK you are running startup application.

### Clone database to non-SQLite database server
If you are not satisfied with sqlite as development database or you are moving 
application into production with different database, AgileRails comes with the Rails task, which will clone data from any to any database server. 
The only requirement is that both databases have working ActiveRecord adapter.

Make sure that you update Gemfile and add ActiveRecord adapter for your destination database and then run bundle update.

Edit config/database.yml. Look for two settings at the end. 
* source - is the source database. By default db/development.sqlite3 which comes with the startup application.
* destination - database that you want to clone source database to. MySQL trilogy ActiveRecord adapter as an example.
Destination database should be empty. There is no need for running migrations before the cloning.
All descriptions will be provided from source database.

Run:
```bash
rails agile:db:clone
```
Depending on number of records the task may take a while to complete. The cloning is not optimized for large number of records.

When the task is completed, update config/database.yml and point development (or any environment) settings to your new database and restart server.
