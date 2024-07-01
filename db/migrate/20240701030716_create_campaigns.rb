class CreateCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :campaigns, id: false do |t|
      t.string :campaign_name
      t.string :campaign_id
      t.timestamps
    end
    execute "ALTER TABLE campaigns ADD PRIMARY KEY (campaign_id);"
  end
end
