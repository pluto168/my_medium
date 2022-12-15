class Story < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true

  default_scope { where(deleted_at: nil)}
  # Ex:- scope :active, -> {where(:active => true)}

  def destroy
    update(deleted_at: Time.now)
  end
end
