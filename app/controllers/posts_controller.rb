class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:create, :edit]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @posts = Post.all
    @user = current_user
    if @user == nil
      redirect_to home_path, notice: 'You must log in to access this page.'
    end
  
  end

  # GET /posts/1/edit
  def edit
    @posts = Post.all
    post = Post.find(params[:id])
    if session[:user_id] == nil
      redirect_to home_path, notice: 'You must log in to access this page.'
    elsif post.user_id != current_user.id
      redirect_to home_path, notice: "This post doesn't belong to you!"
    else 
      render "edit"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params, current_user)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_path(current_user, Post.last), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.user_id != session[:user_id]
      format.html { render "root", notice: "This post doesn't belong to you!" }
    end
    
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_path(session[:user_id], Post.last), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    
    respond_to do |format|
       if session[:user_id] != @post.user_id
        format.html { redirect_to home_path, notice: "This post doesn't belong to you!" }
       else 
        @post.destroy
        format.html { redirect_to user_posts_path(current_user), notice: 'Post was successfully destroyed.' }
       end
      
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @user = User.where(user_id: @post.user_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
