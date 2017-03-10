class QuotesController < ApplicationController
  def index
    company = Company.find_by_id(params[:company_id])
    return head(:not_found) unless company

    render json: company.quotes
  end
end
