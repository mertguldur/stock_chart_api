class QuotesController < ApplicationController
  def index
    company = Company.find_by_id(params[:company_id])
    render json: (company ? company.quotes : [])
  end
end
