class Post < ApplicationRecord
  has_one_attached :image
  
  belongs_to :user
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  
  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
  
  def self.items_serach(search)
   Item.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end

 def save_items(tags)
   current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
   old_tags = current_tags - tags
   new_tags = tags - current_tags

   # Destroy
   old_tags.each do |old_name|
     self.tags.delete Tag.find_by(tag_name:old_name)
   end

   # Create
   new_tags.each do |new_name|
     item_tag = Tag.find_or_create_by(tag_name:new_name)
     self.tags << item_tag
   end
 end
end
