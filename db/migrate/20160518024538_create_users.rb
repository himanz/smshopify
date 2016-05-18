class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :from
      t.integer :step

      t.timestamps null: false
    end
  end
end
