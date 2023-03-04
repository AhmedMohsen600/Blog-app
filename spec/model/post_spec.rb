require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'callbacks' do
    it 'increments the posts_counter of the post author after save' do
      post = user.posts.build(title: 'Test Post', comments_counter: 0, likes_counter: 0)
      expect { post.save }.to change { user.reload.posts_counter }.by(1)
    end
  end

  describe '#recent_comments' do
    it 'returns the last 5 comments of the post' do
      post = Post.create(title: 'Test Post', author: user, comments_counter: 0, likes_counter: 0)
      comments = (1..10).map { |n| post.comments.create(text: "Comment #{n}") }
      expect(post.recent_comments).to eq(comments.last(5))
    end
  end
end
