class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.column :title, :string
      t.column :description, :string
      t.column :image_url, :string
      t.timestamps
    end
  end
end
