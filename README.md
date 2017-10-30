# Introduction to Elm (Workshop)

Interested in Elm, but not sure where to begin? This is the workshop for you!

During this workshop, we will cover the basics of the Elm programming language. We assume prior knowledge only of JavaScript or another imperative or object-oriented language.

At the end of this course, you will be able to:

-  Build an working Elm web app

To achieve that goal, we will cover:

- Basic functional syntax;

- Elm data structures.

- Basics of The Elm Architecture

For this class, you will need to bring and prepare:

- A laptop with internet access

- A GitHub account [https://github.com/]() 

- A way to quickly clone GitHub repos (command line, SourceTree, GitHub Desktop, etc.)
  
  git installers: https://git-scm.com/downloads

### Setup 

Before the workshop, you'll want to make sure that your enviroment and project are setup. Follow the steps below to accomplish this. 

#### Environment
 
1. Install [Node.js 6.9.2](https://nodejs.org) or higher

2. Install the Elm Runtime `npm install -g elm`

3. Install elm-format by running `npm install -g elm-format`

4. Install elm-live by running `npm install -g elm-live@2.6.1`

Note to Mac OS X users: If step 4 gives you an EACCESS error, try this fix:

`sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}`

Then re-run steps 3 and 4

Note: Tab characters are syntax errors in Elm code, so make sure your editor is set to use spaces for this workshop!

#### Setting up the Project
On your computer, complete the following steps:
1. Navigate to a directory on your computer where you have permission to create and edit directories and files
2. Run `git clone https://github.com/mikeonslow/elm-workshop.git`
3. Run `cd elm-workshop`

#### Verify Your Setup
1. Run `elm package install --yes` (this either installs the packages specified in elm-package.json or creates elm-package.json with the core modules)

2. Once that succeeds, run this to verify everything:
   
   `elm-live Main.elm --open --pushstate --output=elm.js`
    
    A browser should open, and you should see this in it:

<img src="https://github.com/mikeonslow/elm-workshop/blob/master/static/verification-success.png" width="350" alt="Verification Image" />

   


