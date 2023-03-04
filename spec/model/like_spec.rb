require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) do
    Post.create(title: 'Title', text: 'first post', author: user, comments_counter: 0, likes_counter: 0)
  end
  subject { Like.new(author: user, post: post) }
  before { subject.save }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'after_save' do
    it 'should update the likes counter of the associated post' do
      expect(post.likes_counter).to eql(1)
    end
  end
end
