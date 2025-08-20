class ApplicationController < ActionController::Base
  before_action :set_security_headers

  allow_browser versions: :modern

  private
  def set_security_headers
    response.set_header('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')
    response.set_header('Pragma', 'no-cache')
    response.set_header('Expires', '0')
    response.set_header('X-Content-Type-Options', 'nosniff')
    response.set_header('X-Frame-Options', 'DENY')
    response.set_header('Content-Security-Policy', "default-src 'self' data: blob:; img-src 'self' data: blob:; media-src 'self' blob:; frame-ancestors 'none';")
  end
end
