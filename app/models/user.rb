class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts
  has_many :relations
  has_many :followings, through: :relations, source: :follow
  has_many :reverses_of_relation, class_name: "Relation", foreign_key: "follow_id"
  has_many :followers, through: :reverses_of_relation,source: :user
  
  has_many :favorites
  has_many :likings, through: :favorites, source: :post 
  
  
  
  def follow(other_user)
    self.relations.find_or_create_by(follow_id: other_user.id) unless self == other_user 
  end
  
  def unfollow(other_user)
    relation = self.relations.find_by(follow_id: other_user.id)
    relation.destroy if relation
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def timeline_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
  
  def like(other_post)
    self.favorites.find_or_create_by(post_id: other_post.id) unless self == other_post
  end
  
  def unlike(other_post)
    favorite = self.favorites.find_by(post_id: other_post.id)
    favorite.destroy if favorite
  end
  
  def liking?(other_post)
    self.likings.include?(other_post)
  end
  
end
