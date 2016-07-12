json.profile do |json|
  json.partial! 'profiles/profile', user: @user
end
