require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  describe 'validations' do
    it { should validate_uniqueness_of :email }

    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("invalid").for(:email) }

    it { should validate_length_of(:password).is_at_least(8).on(:create) }

  end

  describe 'relations' do
    it { should have_many :posts }
  end
end
