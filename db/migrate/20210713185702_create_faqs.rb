class CreateFaqs < ActiveRecord::Migration[6.1]
  def change
    create_table :faqs do |t|
      t.string :en_question
      t.string :zh_tw_question
      t.string :zh_cn_question
      t.string :hm_question
      t.string :vi_question
      t.string :ko_question
      t.string :category
      t.string :tags, array:true, default:[]

      t.timestamps
    end
  end
end
