class PullRequestsCommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_pull_request!

  def index
    @comments = @pull_request.comments.order(created_at: :desc)
  end

  def create
    @comment = @pull_request.comments.new(comment_params)
    @comment.user = current_user

    render json: { errors: @comment.errors }, status: :unprocessable_entity unless @comment.save
  end
  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_pull_request!
    @pull_request = PullRequest.find(params[:pull_request_id])
  end
end
