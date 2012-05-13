class AdminController < ApplicationController
  before_filter :login_required
  auto_complete_for :item, :where_to_do
  
def index
    list
    render :action => 'list'
end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }  
  
def create
  @item = Item.new(params[:item])
   @item.create_date =    Time.local(params[:create_date][:year],params[:create_date][:month],params[:create_date][:day],20,15,1)    
  @item.item_desc = params[:larrytext]
  @item.tag_with(params[:tag_list])
  if @item.save
    flash[:notice] = 'Item  ' + @item.number.to_s + ' was successfully created.'
    redirect_to :action => 'show', :id => @item.id
  else
    render :action => 'new'
  end
end

def destroy
  if params[:ndelete]     
     idwanted = Item.getid(params[:ndelete]).id   
   else    
     idwanted = params[:id]
   end
  Item.find(idwanted).destroy
  redirect_to :action => 'list'
end

def edit
  if params[:nedit]     
    idwanted = Item.getid(params[:nedit]).id   
  else    
    idwanted = params[:id]
  end  
  @item = Item.find(idwanted)
  @lastitem = @item
  @tagfld = find_tagfld
  @tagfld.empty!
end

def find_tagfld
  session[:tagfld] ||= Tagfld.new  
end
  
def list	
	@items =
	if tag_name = params[:id]
    Item.find_tagged_with(tag_name).sort			
	else
		Item.find(:all, :order => "number")
	end	
end

def mungetags 
  @thetags = Item.tags
end

def new
	@lastitem = Item.find(:first, :order => "id DESC")
  @item = Item.new
  @tagfld = find_tagfld
  @tagfld.empty!
 end
 
def new_next 
  @lastitem = Item.find(:first, :order => "id DESC")
  @item = Item.new_next
   @tagfld = find_tagfld
  @tagfld.empty!
end
	
def printview
	@items =
	if tag_name = params[:id]
		Item.find_tagged_with(tag_name).sort
	else
		Item.find(:all, :order => "number")
	end	
end

def se_report
  @ses = Item.find_ses 
end 

def search 
  mysearch = "%" + params[:search_query] + "%"
  @items = Item.find(:all, 
    :conditions => ["item_desc LIKE ?", mysearch], 
    :order => "number")   
    render :action => 'list'
end 

def show
    @item = Item.find(params[:id])
end 
  
def showalltags
     @labels = Label.find(:all, :order => "name")
end
  
def update
	@item = Item.find(params[:id])
	@item.update_attributes(params[:item])
  @item.create_date =    Time.local(params[:create_date][:year],params[:create_date][:month],params[:create_date][:day],20,15,1)    
	@item.tag_with(params[:tag_list])
	@item.save
  flash[:notice] = 'Item was successfully updated.'
  redirect_to :action => 'show', :id => @item		    
end  
  
def uptags
	@taglist = find_tagfld
	if @taglist.isempty
		@taglist.add_atag(params[:tagstr])
	end
 	@taglist.add_atag(params[:id]) 	
 	render :action => "uptags", :layout => false
end      

end