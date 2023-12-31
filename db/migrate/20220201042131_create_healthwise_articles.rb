class CreateHealthwiseArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :healthwise_articles do |t|
      t.string :hwid
      t.string :article_or_topic
      t.string :en_title
      t.jsonb :en_json, default:{}
      t.boolean :en_translated, default:false
      t.string :zh_tw_title
      t.jsonb :zh_tw_json, default:{}
      t.boolean :zh_tw_translated, default:false
      t.string :zh_cn_title
      t.jsonb :zh_cn_json, default:{}
      t.boolean :zh_cn_translated, default:false
      t.string :vi_title
      t.jsonb :vi_json, default:{}
      t.boolean :vi_translated, default:false
      t.string :hm_title
      t.jsonb :hm_json, default:{}
      t.boolean :hm_translated, default:false
      t.string :ko_title
      t.jsonb :ko_json, default:{}
      t.boolean :ko_translated, default:false
      t.string :languages, array:true, default:[]
      t.string :tags, array:true, default:[]
      t.string :category
      t.boolean :featured, default:false
      t.boolean :archive, default:false

      t.timestamps
    end
  end
end
