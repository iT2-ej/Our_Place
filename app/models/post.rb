class Post < ApplicationRecord
  has_one_attached :image
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  
  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end
  
  def self.posts_search(search)
   Post.where(['title LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%"])
  end

 def save_posts(tags)
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
