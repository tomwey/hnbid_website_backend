class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
         
  attr_accessor :login
  
  belongs_to :company
  
  validates :mobile, :nickname, presence: true
  validates :mobile, format: { with: /\A1[3|4|5|7|8|9][0-9]\d{4,8}\z/, message: "请输入11位正确手机号" }, length: { is: 11 }, 
              :uniqueness => true
  validates_uniqueness_of :nickname
              
  def login
    if self.company
      self.company.name
    else
     self.nickname || self.mobile
   end
  end
  
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(nickname) = :value OR lower(mobile) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def update_with_password(params = {})
    if !params[:current_password].blank? or !params[:password].blank? or !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
  end
end
