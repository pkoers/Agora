class CreateStations < ActiveRecord::Migration[7.0]
  def change
    create_table :stations do |t|
      t.string :iata_station_code

      t.timestamps
    end
  end
end
