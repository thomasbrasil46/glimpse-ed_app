module Admin
  class AccessesController < ApplicationController
    # POST /admin/accesses
    # body: { media_group_id: 1, ttl_minutes: 15? }
    def create
      mg = MediaGroup.find(params.require(:media_group_id))
      ttl = params[:ttl_minutes].to_i
      at = mg.access_tokens.create!(expires_at: (ttl > 0 ? ttl.minutes.from_now : nil))
      render json: { token: at.token, expires_at: at.expires_at.iso8601 }
    end
  end
end