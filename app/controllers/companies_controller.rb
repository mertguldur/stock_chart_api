class CompaniesController < ApplicationController
  def index
    companies = Company.search_by_prefix(params[:prefix])
    render json: companies
  end
end
