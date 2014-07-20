phonebuzz-phase-2
=================

A continuation of the phonebuzz exercise.

##Phase 2 Instructions
Point your Twilio number to http://phonebuzz.herokuapp.com/hello, specifying that HTTP GET requests will be used.

If you would like to run the app locally, you can do so as long as you have ruby and bundler installed.

However, you will first need to set up a .env file that contains your Twilio auth token. So:
```
touch .env
```
Open the .env file, and give it a single line of text, like so:
```
AUTH_TOKEN:YOUR_AUTH_TOKEN_HERE
```

Now you're ready to download any dependencies you don't have and run the program.
```
bundle
ruby app.rb
```