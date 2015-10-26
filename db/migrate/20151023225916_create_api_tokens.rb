class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.belongs_to :user
      t.string :token, null: false, default: ""
      t.timestamps null: false
    end
  end
end
