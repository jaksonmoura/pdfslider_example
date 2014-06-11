json.array!(@presentations) do |presentation|
  json.extract! presentation, :id, :user_id_id, :title, :qte_slides
  json.url presentation_url(presentation, format: :json)
end
