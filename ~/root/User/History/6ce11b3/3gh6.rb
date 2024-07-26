class CreateAttachments < ActiveRecord::Migration[7.1]
  def change
    create_table :attachments do |t|
      t.string :name
      t.references :imageable, polymorphic: true
      t.text :content

      t.timestamps
    end
  end
end
