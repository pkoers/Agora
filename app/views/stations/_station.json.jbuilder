json.extract! station, :id, :iata_station_code, :created_at, :updated_at
json.url station_url(station, format: :json)
