class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, :null=> false
      t.integer :year, :null=> false
      t.text :poster_url, :null=> false
      t.text :plot, :null=> false
      t.timestamps
    end
  end
end
