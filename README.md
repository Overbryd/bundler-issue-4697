This repo contains a reproduction of https://github.com/bundler/bundler/issues/4697

# Steps to reproduce (Mac OSX)

    # install stuff to get a docker image built and running
    $ brew install caskroom/cask/brew-cask
    $ brew cask install virtualbox
    $ brew install docker docker-machine
    $ docker-machine create --driver virtualbox default
    $ eval "$(docker-machine env default)"
    
    # build the provided Dockerfile
    $ docker build -t bundler-issue-4697 .
    
    # enter a bash console in the Dockerfile
    $ docker run -ti bundler-issue-4697
    
    # now within the docker image
    > bundle exec rake -vT
    bundler: failed to load command: rake (/home/app/gems/bin/rake)
    LoadError: cannot load such file -- /usr/lib/ruby/gems/2.3.0/gems/rake-10.4.2/bin/rake
      /home/app/gems/bin/rake:22:in `load'
      /home/app/gems/bin/rake:22:in `<top (required)>'
    
    > bundle config path
    Settings for `path` in order of priority. The top value will be used
    Set for the current user (/home/app/.bundle/config): "/home/app/gems"
    
    > ls -lah /home/app/gems/gems/
    total 12
    drwxr-sr-x    3 app      app         4.0K Jun 22 20:37 .
    drwxr-sr-x    9 app      app         4.0K Jun 22 20:37 ..
    drwxr-sr-x    7 app      app         4.0K Jun 22 20:37 rake-10.4.2

