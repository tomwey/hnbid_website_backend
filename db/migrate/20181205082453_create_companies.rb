class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :uniq_id, index: true, unique: true
      t.string :icon, null: false, default: ''
      t.string :name, null: false, default: ''
      t.string :comp_nature, null: false, default: ''
      t.string :business_license_no, null: false, index: true, unique: true
      t.string :business_license_image, null: false
      t.string :safe_license_image
      t.string :address, null: false
      t.date :found_on, null: false
      t.string :reg_fund, null: false
      t.string :reg_address, null: false
      t.string :real_fund_man # 实际出资人
      t.string :tax_type, null: false
      t.string :website # 网站
      t.string :quality_cert # 质量认证
      t.string :legal_man_name, null: false
      t.string :legal_man_tel
      t.string :legal_man_card_type, null: false
      t.string :legal_man_card_no, null: false
      t.string :contact_name
      t.string :contact_tel
      t.text :business_scope # 经营范围
      t.string :right_area
      t.string :service_type
      t.string :business_level # 业务资质
      t.string :year_output_money
      t.string :year_sale_money
      t.text :memo
      t.timestamps null: false
    end
  end
end
