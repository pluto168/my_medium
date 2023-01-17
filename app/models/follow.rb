class Follow < ApplicationRecord
  # belings_to :user, foreign_key: 'user_id', class_name: 'User' 等同下面那行
  belongs_to :user
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'
end
