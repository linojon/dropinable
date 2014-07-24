class AddFileTmpToDropins < ActiveRecord::Migration
  def change
    add_column :dropins, :file_tmp, :string
  end
end
