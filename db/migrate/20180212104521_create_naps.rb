class CreateNaps < ActiveRecord::Migration[5.1]
  def change
    create_table :naps do |t|
      t.references :cat
      t.text :title

      t.timestamps
    end
  end
end
