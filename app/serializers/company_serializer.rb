class CompanySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :symbol, :name

  has_many :quotes, serializer: QuoteSerializer do
    link(:related) { quotes_path(id: object.id) }
    nil
  end
end
