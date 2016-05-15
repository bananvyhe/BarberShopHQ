class CreateContacts < ActiveRecord::Migration
  def change
  	create_table :contacts do |t|
  		t.text :name
  		t.text :text
  		
  		t.timestamps
  	end
  end
end
