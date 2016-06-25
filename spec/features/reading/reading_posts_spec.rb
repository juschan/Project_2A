require 'rails_helper'

RSpec.describe 'Reading posts' do
  let(:user) { User.create(email: 'harry@hogwarts.edu', password: 'super_secret') }

  it 'lets visitors view posts' do
    post = user.posts.create(title: 'Post one', body: 'Body 1')

    visit user_post_path(user, post)

    expect(page.current_path).to eq user_post_path(user, post)
    expect(page).to have_content 'Post one'
    expect(page).to have_content 'Body 1'
  end

  it "shows everyone's posts sorted in reverse chrono order (newest first) on the home page" do
    dumbledore = User.create(email: 'dumbledore@hogwarts.edu', password: 'super_secret')
    snape = User.create(email: 'snape@hogwarts.edu', password: 'super_secret')
    sprout = User.create(email: 'sprout@hogwarts.edu', password: 'super_secret')

    dumbledore.posts.create(title: 'Oldest Title', body: 'oldest body', created_at: 2.days.ago)
    snape.posts.create(title: 'Middle Title', body: 'miiddle body', created_at: 1.day.ago)
    dumbledore.posts.create(title: 'Newest Title', body: 'newest body', created_at: 6.hours.ago)

    ensure_on(home_path)

    posts = page.find_all('.posts .post')
    expect(posts.size).to eq 3

    within posts.first do
      expect(page).to have_content('Newest Title')
      expect(page).to have_content('newest body')
    end

    within posts.last do
      expect(page).to have_content('Oldest Title')
      expect(page).to have_content('oldest body')
    end
  end
end
