class Label < ActiveRecord::Base
	set_table_name "tags"
	
def self.used_tags   
  find_by_sql("select distinct t.name " +
  	"from tags t inner join taggings tg " +
  	"on tg.tag_id = t.id " +
  	"order by t.name")  
end 
  
def self.unused_tags 
  find_by_sql("select id, name from tags " +
  "where id not in (select tag_id from taggings) " +
  "order by name")  
end 
			
end