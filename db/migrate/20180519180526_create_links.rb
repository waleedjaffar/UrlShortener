class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :full_url, null: false
      t.string :short_url, null: false
      t.integer :access_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end
