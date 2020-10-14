require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a valid factory' do
    expect(FactoryBot.create(:user)).to be_valid
  end

  describe 'Database table' do
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :tokens }
    it { is_expected.to have_db_column :role }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_confirmation_of :password }

<<<<<<< HEAD:spec/models/user_spec.rb
  context 'should not have a invalid email address' do
=======
  context 'should not have an invalid email address' do
>>>>>>> ff512c6acf2750cbae85992ebfbaae27b38882f6:spec/models/journalists_spec.rb
    emails = ['ayaf@ dt.com', '@example.com', 'test me @yao.com',
              'asaf@example', 'ddd@.d. .d', 'ddd@.d']

    emails.each do |email|
      it { is_expected.not_to allow_value(email).for(:email) }
    end
  end

  context 'should have a valid email address' do
    emails = ['ayaf@dt.com', 'jenny@example.com', 'testme@yao.com',
              'asaf@example.com']
<<<<<<< HEAD:spec/models/user_spec.rb
    emails.each do |email|
=======
              
    email.each do |email|
>>>>>>> ff512c6acf2750cbae85992ebfbaae27b38882f6:spec/models/journalists_spec.rb
      it { is_expected.to allow_value(email).for(:email) }
      end
    end
  end
end
