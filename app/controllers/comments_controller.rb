class CommentsController < ApplicationController
  before_action :find_entry, only: [:destroy, :create]
  before_action :find_comment, only: [:destroy]
  def create
    @comment = @entry.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.save
    if @comment.save
    	redirect_to entry_path(@entry)
    else
    	render 'new'
    end
  end

  def destroy
    @comment.destroy
     @entry = Entry.find_by id: params[:entry_id]
    redirect_to entry_path(@comment.entry)
  end

  def edit
  end

  def update
  end

	private

    def find_entry
		  @entry = Entry.find_by id: params[:entry_id]
    end

    def find_comment

      @comment = Comment.find_by id: params[:id]
    end
end
