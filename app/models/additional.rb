class Additional < ApplicationRecord
  extend FriendlyId
  friendly_id :en_title, use: %i(slugged history finders)

  scope :filter_by_search, -> (search) { where("en_title ilike ?", "%#{search}%").or(
                                         where("en_source ilike ?", "%#{search}%")).or(
                                         where("en_content ilike ?", "%#{search}%")).or(
                                         where("en_notes ilike ?", "%#{search}%")).or(
                                         where("zh_tw_title ilike ?", "%#{search}%")).or(
                                         where("zh_tw_source ilike ?", "%#{search}%")).or(
                                         where("zh_tw_content ilike ?", "%#{search}%")).or(
                                         where("zh_tw_notes ilike ?", "%#{search}%")).or(
                                         where("zh_cn_title ilike ?", "%#{search}%")).or(
                                         where("zh_cn_source ilike ?", "%#{search}%")).or(
                                         where("zh_cn_content ilike ?", "%#{search}%")).or(
                                         where("zh_cn_notes ilike ?", "%#{search}%")).or(
                                         where("vi_title ilike ?", "%#{search}%")).or(
                                         where("vi_source ilike ?", "%#{search}%")).or(
                                         where("vi_content ilike ?", "%#{search}%")).or(
                                         where("vi_notes ilike ?", "%#{search}%")).or(
                                         where("hm_title ilike ?", "%#{search}%")).or(
                                         where("hm_source ilike ?", "%#{search}%")).or(
                                         where("hm_content ilike ?", "%#{search}%")).or(
                                         where("hm_notes ilike ?", "%#{search}%")).or(
                                         where("ko_title ilike ?", "%#{search}%")).or(
                                         where("ko_source ilike ?", "%#{search}%")).or(
                                         where("ko_content ilike ?", "%#{search}%")).or(
                                         where("ko_notes ilike ?", "%#{search}%")).or(
                                         where("array_to_string(tags,'||') ILIKE :en_title", en_title: "%#{search}%")).or(
                                         where("category ilike ?", "%#{search}%"))
                                       }
end
