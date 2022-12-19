class Story < ApplicationRecord

  #relationships
  belongs_to :user
  
  #驗證title不能空
  validates :title, presence: true

  #scope,軟刪除
  default_scope { where(deleted_at: nil)}        
  # Ex:- scope :active, -> {where(:active => true)}

  #scope published story ,在page#index中只撈出已經發布的文章,AASM可以省掉scope
  #scope :published_stories, -> {where(status: 'published')}

  #軟刪除
  def destroy
    update(deleted_at: Time.now)
  end

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

end
