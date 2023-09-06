class Download < ApplicationRecord
  has_one_attached :en_file, dependent: :destroy
  has_one_attached :zh_tw_file, dependent: :destroy
  has_one_attached :zh_cn_file, dependent: :destroy
  has_one_attached :vi_file, dependent: :destroy
  has_one_attached :hm_file, dependent: :destroy
  has_one_attached :kr_file, dependent: :destroy
  scope :filter_by_search, -> (search) {(where("en_title ilike ?", "%#{search}%")).or(
                                         where("zh_tw_title ilike ?", "%#{search}%")).or(
                                         where("zh_cn_title ilike ?", "%#{search}%")).or(
                                         where("vi_title ilike ?", "%#{search}%")).or(
                                         where("kr_title ilike ?", "%#{search}%")).or(
                                        #  where("tags ilike ?", "%#{search}%")).or(
                                         where("hm_title ilike ?", "%#{search}%"))
                                       }
end
