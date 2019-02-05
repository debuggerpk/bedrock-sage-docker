# Introduction

While [bedrock/trellis/sage](https://roots.io) is a very well thought project, and makes the complete development lifecycle i.e. `design -> code -> release -> deploy` a breeze, the trellis dependency on vagrant makes it slow to develop. This is my attempt to create a boiler plate. The project structure is loosely inspired from [trellis recommended structure](https://roots.io/trellis/docs/installing-trellis/).

## Project Structure

### Bedrock

[bedrock](https://roots.io/bedrock) is present at `site` folder

### Sage

[sage](https://roots.io/sage) is present at `/site/web/app/themes/humans`. I know, _humans_. To rename (please do look at gettings strated), you can do the following, but you should really follow getting started.

```bash
unlink theme
cd /site/web/app/themes
rm -rf humans
composer create-project roots/sage <theme-name>
cd ../../../
ln -s /site/web/app/themes/<theme-name>
```

forget about yarn for now.

### Trellis

[Trellis](https://roots.io/trellis) is at `/trellis`.

## Getting Started

First clone the project.

```bash
git clone --depth=1 git@github.com:debuggerpk/bedrock-sage-docker.git $PROJECT_NAME && rm -rf $PROJECT_NAME/.git
```

where `$PROJECT_NAME` is your project name e.g. `www.example.com` or `blog.your-name.com` or whatever.

### Trellis/Sage: The latest and greatest

To upgrade to latest trellis

```bash
cd $PROJECT_NAME && rm -rf trellis && git clone --depth=1 git@github.com:roots/trellis.git && rm -rf trellis/.git
```

This will remove this trellis and download the latest release.

If you look at the folder structure, you will see a _soft link_ by the name `theme -> site/web/app/themes/humans`. _humans_ is basically [sage](https://roots.io/sage). You would want the latest and greatest here too? right? No Problem. Follow the steps. This assumes that you are in your `$PROJECT_NAME` folder.

```bash
unlink theme
rm -rf humans
composer create-project roots/sage $THEME_NAME
```

When composer is creating a new project for you, On the prompt, devUrl, point it to `http://wp:8080`. This is important, if you don't want to mess with `docker-compose.yml` file. Also, don't do `yarn install` or `yarn build`. Leave that. **Docker** will take care of that.

```bash
cd ../../../
ln -s /site/web/app/themes/$THEME_NAME theme
```

you can take a look at `docker-compose.yml`. All the docker related files are at `/docker` folder. This is a minamal setup, to get you quickly started wtih docker, bedrock, trellis and sage without loosing any of the benefits of either of these. Follow the instructions on each of the package documentation to get started on all them. Now for the fireworks ...

```bash
docker-compose up --build --force-recreate -d
```

## Bonus

Everytime the `wp` image runs, it will keep your `composer` and `composer.lock` upto date with latest packages.

To install more npm package to themes, lets say `turbolinks` npm package

```bash
docker exec -it $THEME_CONTAINER yarn add turbolinks
```

you can get the name of the theme container by doing `docker ps` when your docker-compose is running.
