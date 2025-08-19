class CreateMediaGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :media_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
