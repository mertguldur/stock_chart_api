Given(/^I have companies with names "(.*?)"$/) do |names|
  names = names.split(', ')
  @companies = names.each_with_object({}) do |name, hash|
    hash[name.downcase.to_sym] = Company.create!(symbol: name, name: name)
  end
end

Given(/^I have "(.*?)" companies$/) do |count|
  companies = []
  count.to_i.times do |i|
    companies << Company.new(symbol: "A#{i}", name: "A#{i}")
  end
  Company.import(companies)
end
