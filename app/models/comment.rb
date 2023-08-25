class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  validates :content, presence: true
  validates :dt, presence: true

  def self.to_csv
    attributes = %w{Created_at DT Content Type ID}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      all.each do |comment|
        csv << [comment.created_at, comment.dt, comment.content, comment.commentable_type, comment.commentable_id]
      end
    end
  end
end
