class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :test_string

      t.timestamps null: false
    end
  end
end
