class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :reply]
  respond_to :html , :js
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.hash_tree
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new(parent_id: params[:parent_id],link_id: params[:link_id])
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    lid = params[:link_id] == nil ? params[:comment][:link_id] : params[:link_id]
    @link = Link.find(lid)

    if params[:comment][:parent_id].to_i > 0
      parent = @link.comments.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)

    else
      @comment = @link.comments.new(comment_params)
    end
    @comment.link_id = @link.id
    @comment.user = current_user


    respond_to do |format|
      if @comment.save
        format.html { redirect_to @link, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        logger.debug "ERROR"
        format.json { render :json => { :error => @comment.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @address = @comment.link_id
    respond_to do |format|
      if @comment.update(comment_params)
        #format.html { redirect_to link_url(@address), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.json { render :json => { :error => @comment.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @address = @comment.link_id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to link_url(@address), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
end
