class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :firstname
    	t.string :lastname
      t.string :email
      t.string :avatar
      t.string :password_digest
      t.string :about_me
    end
  end
end
