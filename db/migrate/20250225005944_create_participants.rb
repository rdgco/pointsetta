class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants do |t|
      t.string :name, null: false
      t.references :pointing_session, null: false
      t.boolean :administrator, default: false
      t.integer :vote, null: true

      t.timestamps
    end
  end
end
