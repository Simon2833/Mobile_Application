class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.integer :desk_id
      t.integer :user_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :reservations, :desk_id
    add_index :reservations, :user_id
  end
end
