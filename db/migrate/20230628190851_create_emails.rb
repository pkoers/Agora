class CreateEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :emails do |t|
      t.references :station, null: false, foreign_key: true
      t.string :email_address

      t.timestamps
    end
  end
end
