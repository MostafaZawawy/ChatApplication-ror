# config/initializers/elasticsearch.rb
Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: 'http://localhost:9200',
  log: false,
  transport_options: {
    request: { timeout: 5 }
  }
)
