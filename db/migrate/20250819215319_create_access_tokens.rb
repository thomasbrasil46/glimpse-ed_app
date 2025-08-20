class CreateAccessTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :access_tokens do |t|
      t.string :token
      t.datetime :expires_at
      t.references :media_group, null: false, foreign_key: true

      t.timestamps
    end
    add_index :access_tokens, :token
  end
end
