class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.belongs_to :movie, :null=> false
        t.string :name, :null=> false
        t.text :photo_url, :null=> false
        t.timestamps 
    end
  end
end
