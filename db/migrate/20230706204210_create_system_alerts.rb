class CreateSystemAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :system_alerts do |t|
      t.integer :alert_id
      t.string :alert_content

      t.timestamps
    end
  end
end
