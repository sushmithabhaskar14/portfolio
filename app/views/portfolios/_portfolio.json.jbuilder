json.extract! portfolio, :id, :name, :email, :description, :attachment, :skillset, :url_info, :created_at, :updated_at
json.url portfolio_url(portfolio, format: :json)
