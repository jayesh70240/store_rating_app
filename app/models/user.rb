class User < ApplicationRecord
    has_secure_password
    before_validation :downcase_email
    enum :role, { user: 'User' , store_owner: 'StoreOwner', admin: 'Admin' }
  
    has_one :store, dependent: :destroy
    has_many :ratings, dependent: :destroy
  
    validates :name, presence: true, length: { in: 20..60 }
    validates :address, length: { maximum: 400 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { in: 8..16 }, format: { with: /(?=.*[A-Z])(?=.*\W)/, message: "must include at least 1 uppercase letter and 1 special character" }

    def set_default_role
        self.role = :user unless [:store_owner, :admin].include?(self.role)
    end

    def downcase_email
        self.email = email.downcase if email.present?
    end
end
