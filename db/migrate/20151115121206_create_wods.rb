class CreateWods < ActiveRecord::Migration
  def change
    create_table :wods do |t|
      t.string :title
      t.text :meaning
      t.date :date

      t.timestamps
    end
  end
end
