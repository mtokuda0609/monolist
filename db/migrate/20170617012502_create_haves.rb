class CreateHaves < ActiveRecord::Migration[5.1]
  def change
    create_table :haves do |t|

      t.timestamps
    end
  end
end
