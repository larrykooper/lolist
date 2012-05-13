class ItemController < ApplicationController
	before_filter :login_required
	scaffold :item
	
	def list
		@items = if tag_name = params[:id]
		Tag.find_by_name(tag_name).tagged
		else
			Item.find(:all)
		end
	end
	
	def destroy
		Item.find(params[:id]).destroy
		 
	end
	
	def edit
		@item = Item.find(@params["id"])   
		#  @item is the item we want to edit 
	end
		
	def tag
		item = item.find(params[:id])
		item.tag_with(params[:tag_list])
		item.save
		render :partial => "content", :locals => {:item => item, :form_id => params[:form_id]}
	end

	def update
		@item = Item.find(@params[:id])
		@item.update_attributes(params[:item])
		@item.tag_with(params[:tag_list])
		@item.save
		redirect_to :action => 'list'
			
	end

end
