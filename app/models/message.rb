class Message < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many_attached :en_images, dependent: :destroy
  has_many_attached :vi_images, dependent: :destroy
  has_many_attached :zh_cn_images, dependent: :destroy
  has_many_attached :zh_tw_images, dependent: :destroy
  has_many_attached :hmn_images, dependent: :destroy
  has_one_attached :en_audio, dependent: :destroy
  has_one_attached :vi_audio, dependent: :destroy
  has_one_attached :hmn_audio, dependent: :destroy
  has_one_attached :zh_cn_audio, dependent: :destroy
  has_one_attached :zh_tw_audio, dependent: :destroy
  has_rich_text :en_content
  has_rich_text :zh_tw_content
  has_rich_text :zh_cn_content
  has_rich_text :vi_content
  has_rich_text :hmn_content
  has_rich_text :en_action_item
  has_rich_text :zh_tw_action_item
  has_rich_text :zh_cn_action_item
  has_rich_text :vi_action_item
  has_rich_text :hmn_action_item
  has_rich_text :en_external_rich_links
  has_rich_text :zh_tw_external_rich_links
  has_rich_text :zh_cn_external_rich_links
  has_rich_text :vi_external_rich_links
  has_rich_text :hmn_external_rich_links
  extend FriendlyId
  friendly_id :en_name, use: %i(slugged history finders)
  scope :filter_by_category, -> (category) { where category: category }

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
    attributes = %w{Created_at RCT Content Type ID}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      if comments
        comments.each do |comment|
          csv << [comment.created_at, comment.rct, comment.content, comment.commentable_type, comment.commentable_id]
        end
      end
    end
  end

  def likes_to_csv
    attributes = %w{Created_at RCT Uplikes Downlikes Type ID}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      if likes
        likes.each do |likes|
          csv << [likes.created_at, likes.rct, likes.up, likes.down, likes.likeable_type, likes.likeable_id]
        end
      end
    end
  end

  def should_generate_new_friendly_id? #will change the slug if the en_name changed
    en_name_changed?
  end
end
