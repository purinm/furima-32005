class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  validates :nickname, presence: true

  validates :password, confirmation: true, 
             format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                       message: 'は半角英数字混合で作成してください' }

  with_options presence:true,
    format: { with: /\A[ぁ-んァ-ン一-龥]+\z/,
            message: 'は全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options  presence: true,
                format: { with: /\A[ァ-ン]+\z/,
                message: "は全角カナ文字を使用してください"  } do
      validates :first_furigana
      validates :last_furigana
  end
 
  validates :birthday, presence: true
 
end
