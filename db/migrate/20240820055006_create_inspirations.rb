class CreateInspirations < ActiveRecord::Migration[6.1]
  def change
    create_table :inspirations do |t|
      t.string :en_inspiration
      t.string :zh_cn_inspiration
      t.string :zh_tw_inspiration
      t.string :vi_inspiration
      t.string :hm_inspiration
      t.string :ko_inspiration
      t.string :tags, array:true, default: []
      t.string :category
      t.boolean :featured
      t.boolean :archive
      t.integer :priority

      t.timestamps
    end
  end
end
