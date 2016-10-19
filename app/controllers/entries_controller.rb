class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update]


  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "entry created!"
      redirect_to root_url
    else
    	@feed_items = []
      render 'static_pages/home'
    end
  end


	def show
		@entry = Entry.find_by id: params[:id]
    @comments = Comment.where(entry_id: @entry).order("created_at DESC")
  end

  def destroy
    @entry.destroy
    flash[:success] = "Entry deleted"
    redirect_to request.referrer || root_url
  end

	def edit
		@entry = Entry.find_by id: params[:id]
  end

  def update
    @entry = Entry.find_by id: params[:id]
    if @entry.update_attributes(entry_params)
      flash[:success] = "Entry edited"
      redirect_to @entry
    else
      render 'edit'
    end
  end

  private

    def entry_params
      params.require(:entry).permit(:content, :title, :picture)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
