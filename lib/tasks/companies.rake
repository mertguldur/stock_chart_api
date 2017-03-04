namespace :companies do
  task populate: :environment do
    Company.delete_all
    %w(nasdaq nyse amex).each do |file_name|
      CSV.foreach("csv_files/#{file_name}.csv") do |row|
        next if row.first == 'Symbol'
        next if Company.find_by(symbol: row.first).present?
        Company.create!(symbol: row.first, name: row.second)
      end
    end
  end
end
