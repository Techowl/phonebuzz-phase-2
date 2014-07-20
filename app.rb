require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
# require 'dotenv'
$stdout.sync = true

# Dotenv.load

helpers do
  def request_valid?
    puts '****env********'
    puts env
    puts '***request***'
    puts request.inspect
    puts '***request.url***'
    puts request.url
    puts '***request.original_url***'
    puts request.original_url
    validator = Twilio::Util::RequestValidator.new(ENV['AUTH_TOKEN'])
    puts '***past validator***'
    uri = request.url
    puts '***past uri***'
    params = env['rack.request.query_hash']
    puts '***past params***'
    signature = env['HTTP_X_TWILIO_SIGNATURE']
    puts '***past signature***'
    return validator.validate uri, params, signature
  end
end

error 403 do
  'Access forbidden'
end

get '/hello' do
  return 403 unless request_valid?
  Twilio::TwiML::Response.new do |r|
    r.Gather :finishOnKey => '#', :action => '/hello/fizzbuzz', :method => 'get' do |g|
      g.Say 'Hello! To receive your FizzBuzz results, please enter a number between 1 and 999 followed by the pound sign.'
    end
  end.text
end

get '/hello/fizzbuzz' do
  return 403 unless request_valid?
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