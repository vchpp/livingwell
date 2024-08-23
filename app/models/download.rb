class Download < ApplicationRecord
  has_one_attached :en_file, dependent: :destroy
  has_one_attached :zh_tw_file, dependent: :destroy
  has_one_attached :zh_cn_file, dependent: :destroy
  has_one_attached :vi_file, dependent: :destroy
  has_one_attached :hm_file, dependent: :destroy
  has_one_attached :ko_file, dependent: :destroy
  scope :filter_by_search, -> (search) {(where("en_title ilike ?", "%#{search}%")).or(
                                         where("zh_tw_title ilike ?", "%#{search}%")).or(
                                         where("zh_cn_title ilike ?", "%#{search}%")).or(
                                         where("vi_title ilike ?", "%#{search}%")).or(
                                         where("ko_title ilike ?", "%#{search}%")).or(
                                         where("hm_title ilike ?", "%#{search}%")).or(
                                         where("array_to_string(tags,'||') ILIKE :en_title", en_title: "%#{search}%")).or(
                                         where("category ilike ?", "%#{search}%"))
                                       }
end
