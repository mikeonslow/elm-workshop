# elm-serve

[![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg)](http://standardjs.com/)
[![NPM version](https://img.shields.io/npm/v/elm-serve.svg)](https://www.npmjs.com/package/elm-serve)

Automatically refresh and reload your Elm application in your browser after compile.

## Why?

Restarting your HTTP server and refreshing your browser is annoying. Other reload options do not account for Elm specific behavior when building with Elm `Browser.application`.

## How does it work?

This server works by monitoring changes to the static files that the Elm compiler outputs and updating the browser through WebSockets when they do.

## Installation

```sh
npm install [-g] [--save-dev] elm-serve
```

## Two ways to use `elm-serve`

There are two different ways to use `elm-serve`.

1. As a function call
2. As a command line application

## Using `elm-serve` as function call

When this is used as a function call Reload can be used in conjunction with tools that allow for automatically restarting the server such as [supervisor](https://github.com/isaacs/node-supervisor) (recommended), [nodemon](https://github.com/remy/nodemon), [forever](https://github.com/nodejitsu/forever), etc.

### API

```javascript
elmServe(opts);
```

#### Table of options for reload opts parameter

| Parameter Name | Type    | Description                                                      | Optional | Default         |
| -------------- | ------- | ---------------------------------------------------------------- | -------- | --------------- |
| port           | number  | Port to run reload on.                                           | ✓        | `9856`          |
| host           | string  | If -b flag is being used, this allows for custom hostnames.      | ✓        | `localhost`     |
| dir            | string  | The directory to serve up.                                       | ✓        | `./`            |
| watchDir       | string  | The directory to watch.                                          | ✓        | `./`            |
| exts           | string  | Extensions separated by pipes.                                   | ✓        | `html\|js\|css` |
| startPage      | string  | Specify a start page.                                            | ✓        | `index.html`    |
| open           | boolean | Open in the browser automatically.                               | ✓        | `index.html`    |
| pushstate      | boolean | Automatically serve the root or `index.html` for SPAs.           | ✓        | `index.html`    |
| verbose        | boolean | If set to true, will show logging on the server and client side. | ✓        | `false`         |

### Usage for Command Line Application

```
Usage: elm-serve [options]

Options:

  -h, --help                     output usage information
  -V, --version                  output the version number
  -o, --open                     Open in the browser automatically.
  -n, --host [host]              If -b flag is being used, this allows for custom host. Defaults to localhost.
  -d, --dir [dir]                The directory to serve up. Defaults to current dir.
  -w, --watch-dir [watch-dir]    The directory to watch. Defaults the serving directory.
  -e, --exts [extensions]        Extensions separated by commas or pipes. Defaults to html,js,css.
  -p, --port [port]              The port to bind to. Can be set with PORT env variable as well. Defaults to 8080
  -s, --start-page [start-page]  Specify a start page. Defaults to index.html
  -u, --pushstate [pushstate]    Automatically serve the root or `index.html` for SPAs. Defaults to false.
  -v, --verbose [verbose]        Turning on logging on the server and client side. Defaults to false
```

## License

[(MIT License)](LICENSE)

Copyright 2018

### Owned by:

William King <contact@wking.io>
