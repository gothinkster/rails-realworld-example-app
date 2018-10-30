# frozen_string_literal: true

json.user do |json|
  json.partial! 'users/user', user: current_user
end
