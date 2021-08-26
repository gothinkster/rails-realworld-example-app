json.pull_requests do |json|
  json.array! @pull_requests, partial: 'pull_requests/pull_requests', as: :pull_request
end
