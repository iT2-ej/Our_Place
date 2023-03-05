class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.bigint :post_id, null: false
      t.bigint :tag_id, null: false

      t.timestamps
    end
    
    add_foreign_key :tagmaps, :posts
    add_foreign_key :tagmaps, :tags
  end
end
