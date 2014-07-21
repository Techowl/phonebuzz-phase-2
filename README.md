phonebuzz-phase-2
=================

A continuation of the phonebuzz exercise.

##Phase 2 Instructions
Point your Twilio number to http://phonebuzz2.herokuapp.com/hello, specifying that HTTP GET requests will be used. Note that this is NOT the same as the Heroku address from Phase 1 -- this time, there's a '2' after 'phonebuzz'.

If you would like to run the app locally, you can do so as long as you have ruby and bundler installed.

However, you will first need to set up a .env file that contains your Twilio auth token. So:
```
touch .env
```
Open the .env file, and give it two lines of text, like so:
```
ACCOUNT_SID=YOUR_ACCOUNT_SID_HERE
AUTH_TOKEN=YOUR_AUTH_TOKEN_HERE
```
You will also need to uncomment a couple of specially-marked lines of code near the top of app.rb. Finally, be sure to put your own Twilio phone number into the :from parameter in the /call route of app.rb, and to update the URL in that same route to match the way you're running the app (e.g., :url => 'localhost:4567/hello').

Now you're ready to download any dependencies you don't have and run the program.
```
bundle
ruby app.rb
```

Of course, you can also just observe the app where I have it hosted on Heroku: phonebuzz2.herokuapp.com.