def sign_in_as(user)
  page.visit sign_in_path

  fill_in 'Email', with: 'harry@hogwarts.edu'
  fill_in 'Password', with: 'super_secret'
  click_on 'Sign In'
end
