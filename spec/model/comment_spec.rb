# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'belal gamal', posts_counter: 0) }
  let(:post) { Post.create(title: 'first post', author: user, comments_counter: 0, likes_counter: 0) }
  subject { Comment.new(text: 'first comment', author: user, post: post) }
  before { subject.save }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without text' do
      subject.text = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to :post }
  end

  describe 'callbacks' do
    it 'increments comments_counter on post after save' do
      expect(post.comments_counter).to eq(1)
    end
  end
end
