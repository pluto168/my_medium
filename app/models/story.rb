class Story < ApplicationRecord

  #relationships
  belongs_to :user
  has_many :comments       #一個users有許多留言
  
  
  #驗證title不能空
  validates :title, presence: true

  #scope區:
  #scope,軟刪除,有paranoid就可以關閉
  #default_scope { where(deleted_at: nil)}  Ex:- scope :active, -> {where(:active => true)}

  #scope published story ,在page#index中只撈出已經發布的文章,AASM可以省掉scope
  #scope :published_stories, -> {where(status: 'published')}
  
  scope :published_stories, -> {published.with_attached_cover_image.order(created_at: :desc).includes(:user)}
  scope :popular_stories, -> {published.with_attached_cover_image.order(clap: :desc).limit(10).includes(:user)}
  scope :top1_stories, -> {published.with_attached_cover_image.order(clap: :desc).limit(1).includes(:user)}
  scope :updates_stories, -> {published.with_attached_cover_image.order(updated_at: :desc).limit(3).includes(:user)}
  scope :creat1_stories, -> {published.with_attached_cover_image.order(created_at: :desc).limit(1).includes(:user)}

  #軟刪除,有paranoid就可以關閉
  #def destroy
  #  update(deleted_at: Time.now)
  #end

  #paranoid gem的軟刪除,之前已經建立deleted_at
  acts_as_paranoid

  #狀態機
  include AASM    #t.string "status", default:"draft",#no_direct_assignment是不可直接修改
  aasm(column: 'status',no_direct_assignment: true) do     
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
      #after do
        #puts "發簡訊通知"
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  #網址產生亂數
  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  #babosa顯示中文,搭配FriendlyId
  def normalize_friendly_id(input)
    "#{input.to_s.to_slug.normalize(transliterations: :russian).to_s}-#{SecureRandom.hex[0, 12]}"
  end

  private
  def slug_candidate
    [
      :title
    ]
  end

  #上傳圖片
  has_one_attached :cover_image

  #bookmarks,想要知道這篇文章有多少人標籤起來
  has_many :bookmarks
end
