json.extract! project, :id, :name, :project_url, :description, :attachment, :created_at, :updated_at
json.url project_url(project, format: :json)
