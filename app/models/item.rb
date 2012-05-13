class Item < ActiveRecord::Base
	
	acts_as_taggable
	
	ACTIVITY_TYPES = [
	[ "MAINT", "MAINT" ],
	[ "FO", "FO" ],
	[ "NFS", "NFS" ],
	[ "LA", "LA" ],
	[ "BUDG", "BUDG" ],
	[ "LBETH", "LBETH" ],
	[ "JOBS", "JOBS" ]	
	].freeze 
	
	VALUES_WHENDONE = [
	["A", "A"],
	["B", "B"],
	["C", "C"]
	].freeze	
	
	
	def self.new_next
		theitem = self.new 
		res = Item.connection.select_one("select max(number) as maxnum from items")	
		theitem.number = Integer(res['maxnum']) + 1
		theitem
	end
	
	def self.find_ses	 
	  Item.find_tagged_with("SE").sort	  
  end
  
  def self.getid(lo_number)
    Item.find(:first, :conditions => ["number = ?", lo_number], :select => "id")
  end 
	
	def <=>(other)
		self.number <=> other.number
	end
end