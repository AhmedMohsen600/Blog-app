# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many :comments }
    it { should have_many :likes }
    it { should have_many(:posts).with_foreign_key('author_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#most_recent_posts' do
    let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
    let!(:post1) { Post.create(title: 'first post', author: user, comments_counter: 0, likes_counter: 0) }
    let!(:post2) { Post.create(title: 'second post', author: user, comments_counter: 0, likes_counter: 0) }
    let!(:post3) { Post.create(title: 'third post', author: user, comments_counter: 0, likes_counter: 0) }
    let!(:post4) { Post.create(title: 'fourth post', author: user, comments_counter: 0, likes_counter: 0) }

    it 'returns the three most recent posts for the user' do
      expect(user.most_recent_posts).to eq([post2, post3, post4])
    end
  end
end
