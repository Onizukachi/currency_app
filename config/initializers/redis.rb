url = "redis://#{ENV.fetch("REDIS_HOST") { "redis" }}:#{ENV.fetch("REDIS_PORT") { "6379" }}/1"

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: }
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: }
  end
  $redis = Redis.new(url:)
end
