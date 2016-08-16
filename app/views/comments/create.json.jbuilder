json.comment do |json|
  json.partial! 'comments/comment', comment: @comment
end
