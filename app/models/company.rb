class Company < ApplicationRecord
  validates :symbol, :name, presence: true
  validates :symbol, uniqueness: true

  scope :search_by_prefix, -> (prefix) { where('name ILIKE ?', "#{prefix}%") }
end
