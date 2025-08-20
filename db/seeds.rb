# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

mg = MediaGroup.find_or_create_by!(name: 'Show')
items = [
  { path: 'storage/media/images/estrada.jpg', mime: 'image/jpeg' },
  { path: 'storage/media/images/tobias.jpg', mime: 'image/jpeg' },
  { path: 'storage/media/videos/bea.mp4', mime: 'video/mp4' }
]
items.each do |i|
  next unless File.exist?(Rails.root.join(i[:path]))
  MediaItem.find_or_create_by!(media_group: mg, file_path: i[:path], mime_type: i[:mime])
end
puts "Seed concluído. Grupo: #{mg.id} | Itens: #{mg.media_items.count}"