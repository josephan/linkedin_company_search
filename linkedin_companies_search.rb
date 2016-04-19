require 'linkedin'
require 'csv'
require 'dotenv'
Dotenv.load

# Instantiate a new LinkedIn client using OAuth from gem
client = LinkedIn::Client.new(ENV["LINKEDIN_CLIENT_ID"], ENV["LINKEDIN_CLIENT_SECRET"])

# set request_token, and grab it's token and secret
request_token = client.request_token({})
rtoken = request_token.token
rsecret = request_token.secret

# Check if client request has been previously made by checking access keys
if ENV["LINKEDIN_KEYS"]
  keys = ENV["LINKEDIN_KEYS"].split(",")
  client.authorize_from_access(keys[0], keys[1])
else
  puts request_token.authorize_url
  puts "Please visit the URL above, authorize the app and enter the pin below."
  print "Enter pin: "
  pin = gets.chomp
  keys = client.authorize_from_request(rtoken, rsecret, pin)
  File.open(".env", "a") do |file|
    file.puts "LINKEDIN_KEYS=#{keys.join(",")}"
  end
end

fields = [{ companies: [:id, :name, :'website-url', :'employee-count-range', :'num-followers', :'founded-year'] }]

print "Enter the name of the CSV file:"
filename = gets.chomp

print "Enter the column number with the name of the companies"
column_number = gets.chomp.to_i

array_of_companies = []
CSV.foreach(filename) do |csv|
  puts "Scraping #{csv[column_number]}"
  company_data = []
  result = client.search({keywords: csv[column_number], fields: fields }, :company)
  if result.companies.total > 0
    company = result.companies.all.first
    company_data << csv[column_number]
    company_data << company["id"]
    company_data << company["name"]
    company_data << company["founded_year"] || ""
    company_data << company["employee-count-range"]["name"] unless company["employee-count-range"].nil?
    company_data << company["num-followers"] || ""
    company_data << company["website_url"] || ""
  else
    company_data << "No result for #{csv[column_number]}"
  end
  array_of_companies << company_data
end

puts "assembling csv..."

CSV.open("linkedin_scrape.csv", "wb") do |csv|
  csv << ["Search term", "Linkedin ID", "Name", "Founded Year", "Employee Count", "Number of Followers", "Website URL"]
  array_of_companies.each do |company|
    csv << company
  end
end

puts "Scrape complete! Check linkedin_scrape.csv for your companies!"
