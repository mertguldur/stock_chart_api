class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.text :symbol, null: false
      t.text :name, null: false
      t.index :symbol, unique: true
    end
  end
end
