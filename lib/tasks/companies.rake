namespace :companies do
  task import: :environment do
    folder = 'csv_files'
    file_names = %w(nasdaq nyse amex)
    batch_size = 1000
    companies = []

    file_names.each do |file_name|
      CSV.foreach("#{folder}/#{file_name}.csv") do |row|
        next if row.first == 'Symbol'
        next if Company.find_by(symbol: row.first).present?

        companies << Company.new(symbol: row.first, name: row.second)
        if companies.size == batch_size
          Company.import(companies)
          companies = []
        end
      end
    end
    Company.import(companies)
  end
end
