class CreateDesks < ActiveRecord::Migration[7.1]
  def change
    create_table :desks do |t|
      t.string :status

      t.timestamps
    end
  end
end
