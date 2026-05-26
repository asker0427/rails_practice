require "json"

Game.destroy_all

json_path = Rails.root.join("db", "samplemap.json")
json_data = JSON.parse(File.read(json_path))

game = Game.create!(
  id: 1,
  title: json_data["title"],
  description: "JSONから読み込んだすごろくマップです",
  max_players: 4
)

json_data["squares"].each_with_index do |square, index|
  game.squares.create!(
    position: index,
    square_type: square["type"],
    text: square["text"],
    effect: square["effect"],
    value: square["value"]
  )
end

puts "JSONファイルからのデータ投入が完了しました！"