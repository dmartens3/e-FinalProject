Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://127.0.0.1:3000'  # Add your client's origin here
    resource '*', headers: :any, methods: [:get, :post, :options]
  end
end
