class CreateAircrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :aircrafts do |t|
      t.string :aircraft
      t.string :email_address

      t.timestamps
    end
  end
end
