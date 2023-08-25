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
                                         where("kr_title ilike ?", "%#{search}%")).or(
                                         where("kr_source ilike ?", "%#{search}%")).or(
                                         where("kr_content ilike ?", "%#{search}%")).or(
                                         where("kr_notes ilike ?", "%#{search}%")).or(
                                         where("category ilike ?", "%#{search}%"))
                                       }
end
