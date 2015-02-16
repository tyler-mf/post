module PostsHelper
  def post_params
    params.require(:post).permit(:title, :text, :author, :created, :id)
  end
end
