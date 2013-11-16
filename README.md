# Capifony cPanel

This is an example deploy.rb that I needed to create when deploying a Symfony2 application to a server running cPanel. Follow the step by step guide and you should be up and running.

## Install Capifony 

```
gem install capifony
```

Navigate into your project and run the following command.

```
cd path/to/your/project
capifony .
```

Replace the contents of the generated deploy.rb with the one from the repo. **Remember to change the boilerplate sections to relate to your needs**

add the following to the Capfile in the root of your project

```
default_run_options[:pty] = true
```

## Remove Incenteev Composer Parameter Handler

Remove the following lines from the composer.json file.

```
"incenteev/composer-parameter-handler": "~2.0"
```
```
"Incenteev\\ParameterHandler\\ScriptHandler::buildParameters",
```
```
"Incenteev\\ParameterHandler\\ScriptHandler::buildParameters",
```
```
"incenteev-parameters": {
    "file": "app/config/parameters.yml"
},
```

## Setup

Run the following commands

```
cap deploy:setup
```

Log into the server and copy a already configured parameters.yml or use the one provided in this repo to 
```
shared/app/config
```
*you may need to create this directory structure*. Customise the parameters.yml file as needed.

Your should now be ready to start your first deployment. you should run the following command the first time.

```
cap deploy:cold
```

on subsequent deployments the following command should be used.

```
cap deploy
```

## Cleaning Up

Once your files are on the server you need to symlink

**my-app/current/web to public_html**

```
ln -s my-app/current/web public_html
```

## Useful Links

- [Capifony Website](http://capifony.org/)
- [Capistrano Github](https://github.com/capistrano/capistrano)


