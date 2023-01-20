class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  #relationships
  has_many :stories
  

  #usersname login使用者帳號登入
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  # validates :username, presence: true, uniqueness: true
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  #上傳大頭貼
  has_one_attached :avatar
  

  #follow realtionship
  has_many :follows
  #follow instance methods
  def follow?(user)    # /?代表真假
    # follows.where(following: user) #會回傳一包陣列,比較浪費資源
    follows.exists?(following: user) #exists?是否存在 true/false
  end

  def follow!(user)    # /!代表行為
    if follow?(user)
      follows.find_by(following: user).destroy
      return 'Follow'
    else
      follows.create(following: user)
      return 'Followed'
    end
  end

  #bookmarks一個使用者會有很多書籤
  has_many :bookmarks

  def bookmark?(story)
    bookmarks.exists?(story: story)
  end

  def  bookmark!(story)
    if bookmark?(story)
      bookmarks.find_by(story: story).destroy     #destroy bookmark把書籤關聯拔掉
      return "Unbookmarked"
    else
      bookmarks.create(story: story)
      return "Bookmarked"
    end
  end
  
end
