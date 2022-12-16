class Story < ApplicationRecord

  belongs_to :user
  
  validates :title, presence: true

  default_scope { where(deleted_at: nil)}        
  # Ex:- scope :active, -> {where(:active => true)}

  def destroy
    update(deleted_at: Time.now)
  end

  include AASM         #狀態機
  aasm(column: 'status',no_direct_assignment: true) do         #t.string "status", default:"draft"
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

  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  #babosa
  def normalize_friendly_id(input)
    "#{input.to_s.to_slug.normalize(transliterations: :russian).to_s}-#{SecureRandom.hex[0, 12]}"
  end

  private
  def slug_candidate
    [
      :title
    ]
  end
end
