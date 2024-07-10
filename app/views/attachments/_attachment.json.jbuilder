json.extract! attachment, :id, :name, :content, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
