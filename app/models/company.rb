class Company < ApplicationRecord
  validates :symbol, :name, presence: true
  validates :symbol, uniqueness: true

  scope :search_by_prefix, -> (prefix) { where('name ILIKE ?', "#{prefix}%") }

  HISTORICAL_QUOTE_DAY_INTERVAL = 30

  def quotes
    client = YahooFinance::Client.new
    start_date = Time.now - (24 * 60 * 60 * HISTORICAL_QUOTE_DAY_INTERVAL)
    end_date = Time.now
    time_frame = { start_date: start_date, end_date: end_date }

    quotes = client
      .historical_quotes(symbol, time_frame)
      .sort_by { |quote| Date.parse(quote.trade_date) }

    id = 0
    quotes.map do |quote|
      id += 1
      Quote.new \
        id: id,
        date: quote.trade_date,
        average: average_quote_price(quote)
    end
  end

  private

  def average_quote_price(quote)
    fields = [quote.low, quote.high, quote.open, quote.close]
    sum = fields.inject(0) { |s, n| s + BigDecimal.new(n) }
    num_fields = BigDecimal.new(fields.size.to_s)

    average = sum / num_fields
    '%.2f' %  average.round(2)
  end
end
