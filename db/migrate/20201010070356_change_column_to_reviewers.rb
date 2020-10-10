class ChangeColumnToReviewers < ActiveRecord::Migration[5.2]
  def change
    change_column :reviewers, :profile_image_id, :string, null: false, default: ""

  end
end
