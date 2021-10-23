class CreateGeoms < ActiveRecord::Migration[6.1]
  def change
    create_table :geoms do |t|
      t.geometry 'location', null: false

      t.timestamps
    end
  end
end
