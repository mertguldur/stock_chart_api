class CompaniesController < ApplicationController
  def index
    companies = Company
      .search_by_prefix(params[:prefix])
      .order(:name).page(params[:page])

    render json: companies, meta: { pagination: pagination(companies) }
  end

  private

  def pagination(companies)
    {
      per_page: Kaminari.config.default_per_page,
      total_pages: companies.total_pages,
      total_count: companies.total_count
    }
  end
end
