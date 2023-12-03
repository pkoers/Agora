class DropAdministratorTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :administrators
  end

  def down
    create_table :administrators do |t|
      t.boolean :trusted
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
