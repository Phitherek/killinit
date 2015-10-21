class CreateKillinIts < ActiveRecord::Migration
  def change
    create_table :killin_its do |t|
      t.belongs_to :from_user
      t.belongs_to :to_user
      t.string :message
      t.timestamps null: false
    end
  end
end
