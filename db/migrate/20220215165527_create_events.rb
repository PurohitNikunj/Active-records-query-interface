class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.date :event_date
      t.belongs_to :category, foreign_key: true
      
      t.timestamps
    end
  end
end
