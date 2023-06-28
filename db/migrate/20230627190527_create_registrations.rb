class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.string :registration
      t.string :email_address

      t.timestamps
    end
  end
end
