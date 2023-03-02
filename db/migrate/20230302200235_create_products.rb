class CreateProducts < ActiveRecord::Migration[7.0]
  def self.up
    create_table :products do |t|
      t.string :admin
      t.column :title, :string
      t.column :description, :text
      t.column :image_url, :string

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
