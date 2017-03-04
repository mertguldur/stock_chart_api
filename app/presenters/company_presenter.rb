class CompanyPresenter
  def initialize(company)
    @company = company
  end

  def as_json(_options = {})
    {
      symbol: @company.symbol,
      name: @company.name
    }
  end
end
