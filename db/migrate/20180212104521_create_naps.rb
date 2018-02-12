class CreateNaps < ActiveRecord::Migration[5.1]
  def change
    create_table :naps do |t|
      t.references :cat
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
