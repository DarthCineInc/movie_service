class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.date :release_date
      t.string :image

      t.timestamps
    end
  end
end
