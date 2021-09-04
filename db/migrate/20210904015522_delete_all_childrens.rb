class DeleteAllChildrens < ActiveRecord::Migration[6.1]
  def change
    create_table :delete_all_children do |t|
      t.references :delete_all_parent, foreign_key: true, null: false
    end
  end
end
