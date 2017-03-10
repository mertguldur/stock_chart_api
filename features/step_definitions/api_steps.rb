require 'jsonpath'

When(/^I send a (GET|PATCH|POST|PUT|DELETE) request (?:for|to) "([^"]*)"(?: with the following:)?$/) do |*args|
  request_type = args.shift
  path = eval("\"#{args.shift}\"")
  input = args.shift
  options = { method: request_type.downcase.to_sym }
  unless input.nil?
    if input.class == Cucumber::MultilineArgument::DataTable
      options[:params] = input.rows_hash
    else
      options[:input] = StringIO.new(input)
    end
  end
  request(path, options)
end

Then(/^the response status should be "([^"]*)"$/) do |status|
  expect(last_response.status).to eq(status.to_i)
end

Then(/^the JSON response data should be:$/) do |json|
  json = eval(json).to_json
  expected = JSON.parse(json)
  actual = JSON.parse(last_response.body)['data']
  expect(actual).to eq(expected)
end

Then(/^the JSON response pagination data should be:$/) do |json|
  expected = JSON.parse(json)
  actual = JSON.parse(last_response.body)['meta']['pagination']
  expect(actual).to eq(expected)
end

Then(/^I should only see "(.*?)" items in JSON response data$/) do |number|
  num_items = JSON.parse(last_response.body)['data'].size
  expect(num_items).to eq(number.to_i)
end
