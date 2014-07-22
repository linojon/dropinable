class CreateDropins < ActiveRecord::Migration
  def change
    create_table :dropins do |t|
      t.references :dropinable, polymorphic: true
      t.string :scope
      t.string :file
      t.timestamps
    end
  end
end
