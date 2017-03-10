Given(/^I have companies with names "(.*?)"$/) do |names|
  names = names.split(', ')
  @companies = names.each_with_object({}) do |name, hash|
    hash[name] = Company.create!(symbol: name, name: name)
  end
end

Given(/^I have "(.*?)" companies$/) do |count|
  companies = []
  count.to_i.times do |i|
    companies << Company.new(symbol: "A#{i}", name: "A#{i}")
  end
  Company.import(companies)
end

Given(/^I have a company$/) do
  @company = Company.create!(symbol: 'FOO', name: 'Bar')
end

Given(/^Yahoo Finance API is able to return quotes with the following attributes$/) do |table|
  client = YahooFinance::Client.new
  allow(YahooFinance::Client).to receive(:new) { client }

  quotes = table.hashes.map { |hash| OpenStruct.new(hash) }
  allow(client).to receive(:historical_quotes) { quotes }
end
