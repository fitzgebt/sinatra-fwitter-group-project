class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true

  def slug
    self.username.downcase.gsub(" ", "-")
  end
  
  def self.find_by_slug(slug)
    self.all.find {|s| s.slug == slug}
  end
end
