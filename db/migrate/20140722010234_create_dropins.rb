class CreateDropins < ActiveRecord::Migration
  def change
    create_table :dropins do |t|
      t.references :dropinable, polymorphic: true
      t.string :scope
      t.string :file
      t.timestamps
    end
    add_index :dropins, [:dropinable_type, :dropinable_id, :scope], name: 'by_scoped_parent'
  end
end
