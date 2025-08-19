class MediaGroup < ApplicationRecord
    has_many :media_items, dependent: :destroy
    has_many :access_tokens, dependent: :destroy
end
