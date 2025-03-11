class CreatePointingSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :pointing_sessions do |t|
      t.timestamps
      t.string :name, null: false, index: { unique: true }
      t.string :topic, :string
    end
  end
end
