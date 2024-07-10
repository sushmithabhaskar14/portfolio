class CreatePortfolios < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolios do |t|
      t.string :name
      t.string :email
      t.string :description
      t.text :attachment
      t.json :skillset
      t.json :url_info

      t.timestamps
    end
  end
end
