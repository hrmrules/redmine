Instaling and configuring Redmine for Oracle
============================================

Redmine prerequisites
---------------------
Redmine is a Ruby on Rails application. The easiest way to install is via RubyGems.
Redmine need the enhanced Oracle adapter to use Oracle as backend.

This document describes a completely basic, standalone Redmine install with Oracle.
In production one would probably use apache and rvm.

**Linux dependencies**
`sudo apt-get install ImageMagick`
`sudo apt-get install libmagickwand-dev`

**Oracle client**
Install Oracle instant client AND Oracle Instant client SDK!
In $ORACLE_HOME do: `sudo ln -s libclntsh.so.11.1 libclntsh.so`
This directory will be referred to as ORACLE_HOME in the following.
Set the global (or local) variable `TNS_LANG=american_america.AL32UTF8`

**Installing ruby**
Ubuntu: `sudo apt-get install ruby ruby-dev` 

**Installing gems**
Ubuntu: `sudo gem install bundler`
Ubuntu: `sudo gem install rake`

Oracle:
`sudo env LD_LIBRARY_PATH=$ORACLE_HOME gem install ruby-oci8`

**Basic Redmine install**
Redmine has been cloned and set up for Oracle use.
There are quite a few database script changes and a couple of application
changes that are required for using the oracle back-end. An Oracle targeted
fork of Redmine is available from the following repositiory:

`git clone https://github.com/hrmrules/redmine-oracle.git`
In the redmine-oracle directory: `git checkout 2.6.1-oracle`

In the following REDMINE_HOME refers to this directory.

**Configuring database**
Create a database schema for use with Redmine.

Adjust the database set-up file REDMINE_HOME/config/database.yml (create this file, if necessary):
```
production:
  adapter: oracle_enhanced
  host: localhost
  port: 1521
  database: XE
  username: username
  password: pass
```
Host, port, database, username and password are, of course, installation dependent.

**Installing Redmine ruby dependencies**
From the Redmine directory:
`bundle install --without development test`


Redmine configuration and set-up
--------------------------------
In REDMINE_HOME:
Generate secret token for cookie generation: `rake generate_secret_token`
Create database objects `RAILS_ENV=production rake db:migrate`
Load master data: `RAILS_ENV=production REDMINE_LANG=en rake redmine:load_default_data`

Note that it is possible to specify another language. Danish for instance with REDMINE_LANG=da.

Starting Redmine
----------------
In this case we just start Redmine with he default ruby webserver, webrick. In a production environment
it is recommended to use a "proper" web server front-end like Apache.

`ruby script/rails server webrick -e production`
Initial logon: admin/admin
Create database objects `RAILS_ENV=production rake db:migrate`
