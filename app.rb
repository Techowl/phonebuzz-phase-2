require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'dotenv'

# $stdout.sync = true # for debugging
Dotenv.load

helpers do
  def request_valid?
    validator = Twilio::Util::RequestValidator.new(ENV['AUTH_TOKEN'])
    uri = request.url
    params = {} # We're using a GET request, so this needs to be empty.
    signature = env['HTTP_X_TWILIO_SIGNATURE']
    return validator.validate uri, params, signature
  end

  def invalid_call
    redirect '/invalid'
  end
end

['/hello', '/hello/*'].each do |path|
  before path do
    invalid_call unless request_valid?
  end
end

get '/' do
  erb :index
end

get '/hello' do
  Twilio::TwiML::Response.new do |r|
    r.Gather :finishOnKey => '#', :action => '/hello/fizzbuzz', :method => 'get' do |g|
      g.Say 'Hello! To receive your FizzBuzz results, please enter a number between 1 and 999 followed by the pound sign.'
    end
  end.text
end

get '/hello/fizzbuzz' do
  number = params['Digits'].to_i
  redirect '/hello' unless (number >= 1 && number <= 999)
  Twilio::TwiML::Response.new do |r|
    number.times do |i|
      curr_num = i + 1
      if curr_num % 15 == 0
        r.Say "fizz buzz"
      elsif curr_num % 5 == 0
        r.Say "buzz"
      elsif curr_num % 3 == 0
        r.Say "fizz"
      else
        r.Say "#{curr_num}"
      end
    end
  end.text
end

post '/call' do
  client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
  call = client.account.calls.create(
    :from => '+13373264355',
    :to => params['numToCall'],
    :url => 'http://phonebuzz2.herokuapp.com/hello',
    :timeout => '20',
    :method => 'get'
  )
end

get '/invalid' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'Invalid request.'
  end.text
end