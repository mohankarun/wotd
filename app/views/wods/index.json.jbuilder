json.array!(@wods) do |wod|
  json.extract! wod, :id, :title, :meaning, :date
  json.url wod_url(wod, format: :json)
end
