class Message < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many_attached :en_images, dependent: :destroy
  has_many_attached :vi_images, dependent: :destroy
  has_many_attached :zh_cn_images, dependent: :destroy
  has_many_attached :zh_tw_images, dependent: :destroy
  has_many_attached :hm_images, dependent: :destroy
  has_many_attached :ko_images, dependent: :destroy
  has_one_attached :en_audio, dependent: :destroy
  has_one_attached :vi_audio, dependent: :destroy
  has_one_attached :hm_audio, dependent: :destroy
  has_one_attached :ko_audio, dependent: :destroy
  has_one_attached :zh_cn_audio, dependent: :destroy
  has_one_attached :zh_tw_audio, dependent: :destroy
  has_rich_text :en_content
  has_rich_text :zh_tw_content
  has_rich_text :zh_cn_content
  has_rich_text :vi_content
  has_rich_text :hm_content
  has_rich_text :ko_content
  has_rich_text :en_action_item
  has_rich_text :zh_tw_action_item
  has_rich_text :zh_cn_action_item
  has_rich_text :vi_action_item
  has_rich_text :hm_action_item
  has_rich_text :ko_action_item
  has_rich_text :en_external_rich_links
  has_rich_text :zh_tw_external_rich_links
  has_rich_text :zh_cn_external_rich_links
  has_rich_text :vi_external_rich_links
  has_rich_text :hm_external_rich_links
  has_rich_text :ko_external_rich_links
  extend FriendlyId
  friendly_id :en_name, use: %i(slugged history finders)
  scope :filter_by_category, -> (category) { where category: category }
  scope :filter_by_search, -> (search) { where("en_name ilike ?", "%#{search}%").or(
                                        where("zh_tw_name ilike ?", "%#{search}%")).or(
                                        where("vi_name ilike ?", "%#{search}%")).or(
                                        where("ko_name ilike ?", "%#{search}%")).or(
                                        where("hm_name ilike ?", "%#{search}%")).or(
                                        where("category ilike ?", "%#{search}%")).or(
                                        where("array_to_string(tags,'||') ILIKE :en_name", en_name: "%#{search}%"))
                                        }

  def self.to_csv
    attributes = %w{id
      created_at
      en_name
      category
      archive}

    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      all.each do |message|
        csv << attributes.map{ |attr| message.send(attr) }
      end
    end
  end

  def comments_to_csv
    attributes = %w{Created_at DT Content Type ID}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      if comments
        comments.each do |comment|
          csv << [comment.created_at, comment.dt, comment.content, comment.commentable_type, comment.commentable_id]
        end
      end
    end
  end

  def likes_to_csv
    attributes = %w{Created_at DT Uplikes Downlikes Type ID}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      if likes
        likes.each do |likes|
          csv << [likes.created_at, likes.dt, likes.up, likes.down, likes.likeable_type, likes.likeable_id]
        end
      end
    end
  end

  def should_generate_new_friendly_id? #will change the slug if the en_name changed
    en_name_changed?
  end
end
