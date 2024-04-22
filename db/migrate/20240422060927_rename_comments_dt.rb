class RenameCommentsDt < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :dt, :tid
  end
end
