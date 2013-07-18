class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :email
      t.text :message

      t.timestamps
    end

    add_index :feedbacks, :email
  end
end
