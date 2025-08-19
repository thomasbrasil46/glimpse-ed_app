class TokenVerifier
  def self.find_valid!(token_str)
    token = AccessToken.find_by(token: token_str)
    raise ActiveRecord::RecordNotFound, 'token inválido' unless token
    raise StandardError, 'token expirado' if token.expired?
    token
  end
end