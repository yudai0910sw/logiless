require 'net/http'
require 'uri'
require 'json'
require 'csv'
require 'dotenv'

Dotenv.load
merchant_id = 2655
url = URI("https://app2.logiless.com/api/v1/merchant/#{merchant_id}/sales_orders")
params = {
  limit: 5,
  page: 1,
}
url.query = URI.encode_www_form(params)

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
request = Net::HTTP::Get.new(url)

access_token = ENV['ACCESS_TOKEN']
request["Authorization"] = "Bearer #{access_token}"

response = http.request(request)
result = JSON.parse(response.body)

puts result

File.open("output.json", "w") do |file|
  file.write(JSON.pretty_generate(result))
end

