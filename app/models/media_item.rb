class MediaItem < ApplicationRecord
  belongs_to :media_group
  validates :file_path, :mime_type, presence: true

  def absolute_path
    Rails.root.join(file_path)
  end

  def exist?
    File.exist?(absolute_path)
  end
end
