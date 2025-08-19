class AccessToken < ApplicationRecord
  belongs_to :media_group
  before_validation :ensure_token_and_expiration, on: :create

  scope :valid_now, -> { where('expires_at > ?', Time.current) }

  def expired?
    Time.current >= expires_at
  end

  private
  def ensure_token_and_expiration
    self.token ||= SecureRandom.urlsafe_base64(24)
    ttl = ENV.fetch('TOKEN_TTL_MINUTES', '15').to_i
    self.expires_at ||= ttl.minutes.from_now
  end
end
