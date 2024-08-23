class Inspiration < ApplicationRecord
  scope :filter_by_search, -> (search) {(where("en_inspiration ilike ?", "%#{search}%")).or(
    where("zh_tw_inspiration ilike ?", "%#{search}%")).or(
    where("zh_cn_inspiration ilike ?", "%#{search}%")).or(
    where("vi_inspiration ilike ?", "%#{search}%")).or(
    where("ko_inspiration ilike ?", "%#{search}%")).or(
    where("hm_inspiration ilike ?", "%#{search}%")).or(
    where("array_to_string(tags,'||') ILIKE :en_inspiration", en_inspiration: "%#{search}%")).or(
    where("category ilike?", "%#{search}%"))
  }
end
