class LabelController < ApplicationController
  
before_filter :login_required

 def destroy
   idwanted = params[:id]
   Label.find(idwanted).destroy
   redirect_to :action => 'tag_report'
 end 
		
	def list
		@labels = Label.find(:all, :order => "name")
		if params[:id] == "rows" 
			render (:template => "label/listrows")
		end
	end
	
	def tag_report 
	  @used_tags = Label.used_tags  
	  @unused_tags = Label.unused_tags 	  
	end 
	
end