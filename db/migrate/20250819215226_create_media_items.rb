class CreateMediaItems < ActiveRecord::Migration[8.0]
  def change
    create_table :media_items do |t|
      t.references :media_group, null: false, foreign_key: true
      t.string :file_path
      t.string :mime_type

      t.timestamps
    end
  end
end
