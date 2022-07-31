class RenameImageColumnToPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :image, :image_id
  end
end
