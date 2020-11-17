class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  validates :password, presence: true, confirmation: true, length: { minimum: 6, message: '6文字以上入力してください' },
                       format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}\z/,
                                 message: 'は英数字混合で入力してください' }

  with_options presence: true,
               format: { with: /\A[ぁ-んァ-ン一-龥]+\z/,
                         message: 'は全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options  presence: true,
                format: { with: /\A[ァ-ン]+\z/,
                          message: 'は全角カナ文字を使用してください' } do
    validates :first_furigana
    validates :last_furigana
  end
end
