class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :meaning
      t.date :date

      t.timestamps
    end
  end
end
