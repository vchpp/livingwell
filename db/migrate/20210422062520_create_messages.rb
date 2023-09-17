class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :en_name
      t.string :en_content
      t.string :zh_cn_name
      t.string :zh_cn_content
      t.string :zh_tw_name
      t.string :zh_tw_content
      t.string :vi_name
      t.string :vi_content
      t.string :hm_name
      t.string :hm_content
      t.string :ko_name
      t.string :ko_content
      t.string :tags, array:true, default:[]

      t.timestamps
    end
  end
end
