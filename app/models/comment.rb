class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :story

   #paranoid gem的軟刪除,之前已經建立deleted_at
   acts_as_paranoid

   #驗證content,內容有東西才可送出
   validates :content ,presence: true 
end
