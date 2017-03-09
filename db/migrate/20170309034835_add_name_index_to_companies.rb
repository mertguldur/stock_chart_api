class AddNameIndexToCompanies < ActiveRecord::Migration[5.0]
  def change
    execute "CREATE INDEX name_idx ON companies USING gin (name gin_trgm_ops);"
  end
end
