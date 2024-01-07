class AddPriorityToHealthwiseArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :healthwise_articles, :priority, :integer, default: nil
  end
end
