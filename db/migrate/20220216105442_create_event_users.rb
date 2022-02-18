class CreateEventUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :event_users do |t|
      t.belongs_to :event
      t.belongs_to :user
      t.integer :status

      t.timestamps
    end
  end
end
