namespace :cleanup do
  desc 'Remove tokens expirados (logicamente)'
  task tokens: :environment do
    expired = AccessToken.where('expires_at < ?', Time.current)
    puts "Expirados: #{expired.count}"
    # Caso queira apagar:
    expired.delete_all
  end
end