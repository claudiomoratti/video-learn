require 'rails_helper'

RSpec.describe "/comments", type: :request do
  let!(:lesson) {create(:lesson)}
  # Comment. As you add validations to Comment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
        lesson_id: lesson.id,
        author: 'James',
        content: 'I really like this video'
    }
  }

  let(:invalid_attributes) {
    {
        lesson_id: nil,
        author: 'James Tont',
        content: 'Why?'
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Comment.create! valid_attributes
      get lesson_comments_url(lesson)
      expect(response).to be_successful
    end

    it "renders a successful json response" do
      comment = Comment.create! valid_attributes
      get lesson_comments_url(lesson, format: :json)
      expect(response.body).to include_json([{author: 'James', content: comment.content}])
    end
  end

  describe "GET /show" do
    it "renders a successful json response" do
      comment = Comment.create! valid_attributes
      get lesson_comment_url(lesson, comment, format: :json)
      expect(response.body).to include_json(comment.as_json)
    end

    it "renders a successful response" do
      comment = Comment.create! valid_attributes
      get lesson_comment_url(lesson, comment)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_lesson_comment_url(lesson)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      comment = Comment.create! valid_attributes
      get edit_lesson_comment_url(lesson, comment)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post lesson_comments_url(lesson), params: {comment: valid_attributes}
        }.to change(Comment, :count).by(1)
      end

      it "creates a new Comment from API" do
        post lesson_comments_url(lesson, format: :json), params: {comment: valid_attributes}
        expect(response.body).to include_json(valid_attributes)
      end

      it "redirects to the created comment" do
        post lesson_comments_url(lesson), params: {comment: valid_attributes}
        expect(response).to redirect_to(lesson_comment_url(lesson, Comment.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post lesson_comments_url(lesson), params: {comment: invalid_attributes}
        }.to change(Comment, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {author: 'Gino'}
      }

      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        patch lesson_comment_url(lesson, comment), params: {comment: new_attributes}
        comment.reload
        expect(comment.author).to eq('Gino')
      end

      it "updates the requested comment via API" do
        comment = Comment.create! valid_attributes
        patch lesson_comment_url(lesson, comment, format: :json), params: {comment: new_attributes}
        comment.reload
        expect(comment.author).to eq('Gino')
        expect(response.body).to include_json(comment.as_json)
      end

      it "redirects to the comment" do
        comment = Comment.create! valid_attributes
        patch lesson_comment_url(lesson, comment), params: {comment: new_attributes}
        comment.reload
        expect(response).to redirect_to(lesson_comment_url(lesson, comment))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete lesson_comment_url(lesson, comment)
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      comment = Comment.create! valid_attributes
      delete lesson_comment_url(lesson, comment)
      expect(response).to redirect_to(lesson_comments_url(lesson))
    end
  end
end
