require 'rails_helper'

RSpec.describe 'Signing up' do
  before do
    ensure_on home_path
    click_on 'Sign Up'
  end

  it 'lets the user sign up' do
    fill_in 'Email', with: 'hermione@hogwarts.edu'
    fill_in 'Password', with: 'super_secret'
    click_on 'Sign Up'

    expect(page).to have_content('Welcome')
  end

  it 'shows validation errors' do
    fill_in 'Email', with: 'not an email'
    fill_in 'Password', with: '123'
    click_on 'Sign Up'

    expect(page).to_not have_content('Welcome')
    expect(page).to have_content('Email is invalid')
    expect(page).to have_content('Password is too short (minimum is 8 characters)')
  end
end
