class AddRichTextsToHealthwiseArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :healthwise_articles, :en_rich_text, :string, default: nil
    add_column :healthwise_articles, :zh_tw_rich_text, :string, default: nil
    add_column :healthwise_articles, :zh_cn_rich_text, :string, default: nil
    add_column :healthwise_articles, :vi_rich_text, :string, default: nil
    add_column :healthwise_articles, :hm_rich_text, :string, default: nil
    add_column :healthwise_articles, :kr_rich_text, :string, default: nil
  end
end
