# coding: utf-8
class Company < ActiveRecord::Base
  # validates :name, :icon, :comp_nature, :business_license_no, :business_license_image,
  # :address, :found_on, :reg_fund, :reg_address, :tax_type, :legal_man_name, :legal_man_tel, :legal_man_card_type, :business_scope,
  # :legal_man_card_no, presence: true
  has_many :users, dependent: :destroy
  
  mount_uploader :icon, AvatarUploader
  mount_uploader :business_license_image, CommonImageUploader
  mount_uploader :safe_license_image, CommonImageUploader
  
  attr_writer :current_step
  
  validates_presence_of :name,:comp_nature,:business_license_no,:address,:found_on,:reg_fund,:reg_address,:tax_type,:legal_man_name,:legal_man_tel,:legal_man_card_type,:business_scope,:legal_man_card_no, if: lambda { |o| o.current_step == "base" }
  # validates_presence_of :billing_name, if: lambda { |o| o.current_step == "services" }
  # validates_presence_of :icon, :business_license_image, if: lambda { |o| o.current_step == "license" }
  # validates_presence_of :billing_name, if: lambda { |o| o.current_step == "performance" }
  
  before_create :generate_uniq_id
  def generate_uniq_id
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..8]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
  end
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[base services performance license]
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
  
end
