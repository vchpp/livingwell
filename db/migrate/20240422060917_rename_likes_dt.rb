class RenameLikesDt < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :dt, :tid
  end
end
