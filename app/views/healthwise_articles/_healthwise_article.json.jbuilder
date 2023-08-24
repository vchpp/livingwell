json.extract! healthwise_article, :id, :hwid, :type, :en_title, :en_json, :en_translated, :zh_tw_title, :zh_tw_json, :zh_tw_translated, :zh_cn_title, :zh_cn_json, :zh_cn_translated, :vi_title, :vi_json, :vi_translated, :hm_title, :hm_json, :hm_translated, :languages, :array, :category, :featured, :archive, :created_at, :updated_at
json.url healthwise_article_url(healthwise_article, format: :json)
