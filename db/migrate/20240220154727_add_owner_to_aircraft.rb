class AddOwnerToAircraft < ActiveRecord::Migration[7.0]
  def change
    add_reference :aircrafts, :owner, foreign_key: true
  end
end
