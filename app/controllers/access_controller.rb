class AccessController < ApplicationController
  # GET /access/:token
  def show
    token = TokenVerifier.find_valid!(params[:token])
    items = token.media_group.media_items
    render json: {
      media_group: { id: token.media_group.id, name: token.media_group.name },
      expires_at: token.expires_at.iso8601,
      items: items.map { |i| { id: i.id, mime_type: i.mime_type } }
    }
  rescue => e
    render json: { error: e.message }, status: :unauthorized
  end

  # GET /stream/:token/:id
  def stream
    token = TokenVerifier.find_valid!(params[:token])
    item = token.media_group.media_items.find(params[:id])
    unless item.exist?
      return render json: { error: 'Arquivo não encontrado' }, status: :not_found
    end

    # Evitar exposição de path e forçar inline
    response.headers['Content-Disposition'] = 'inline'
    response.headers['Cache-Control'] = 'no-store'

    # Suporte a range requests para vídeo
    send_file item.absolute_path,
              type: item.mime_type,
              disposition: 'inline',
              stream: true,
              x_sendfile: false
  rescue => e
    render json: { error: e.message }, status: :unauthorized
  end
end