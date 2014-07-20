require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'openssl'
require 'base64'
# require 'dotenv'  # uncomment this line to run locally
$stdout.sync = true

# Dotenv.load   # uncomment this line to run locally

helpers do
  def request_valid?
    # validator = Twilio::Util::RequestValidator.new(ENV['AUTH_TOKEN'])
    uri = request.url
    params = env['rack.request.query_hash']
    signature = env['HTTP_X_TWILIO_SIGNATURE']
    puts '***token***'
    puts ENV['AUTH_TOKEN']
    # data = uri + params.sort.join
    data = uri
    puts '***data***'
    puts data
    digest = OpenSSL::Digest.new('sha1')
    puts '***digest***'
    puts digest
    encoded = Base64.encode64(OpenSSL::HMAC.digest(digest, ENV['AUTH_TOKEN'], data)).strip
    puts '***encoded***'
    puts encoded
    puts '***signature***'
    puts signature
    puts '***result***'
    puts signature == encoded
    return signature == encoded

    # puts validator.validate uri, params, signature
    # return validator.validate uri, params, signature
  end
end

get '/hello' do
  Twilio::TwiML::Response.new do |r|
    unless request_valid?
      r.Say 'Invalid request.'
    else
      r.Gather :finishOnKey => '#', :action => '/hello/fizzbuzz', :method => 'get' do |g|
        g.Say 'Hello! To receive your FizzBuzz results, please enter a number between 1 and 999 followed by the pound sign.'
      end
    end
  end.text
end

get '/hello/fizzbuzz' do
  number = params['Digits'].to_i
  redirect '/hello' unless (number >= 1 && number <= 999)
  Twilio::TwiML::Response.new do |r|
    unless request_valid?
      r.Say 'Invalid request.'
    else
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
    end
  end.text
end