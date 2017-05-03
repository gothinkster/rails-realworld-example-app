# frozen_string_literal: true

json.profile do |json|
  json.partial! 'profiles/profile', user: @user
end
