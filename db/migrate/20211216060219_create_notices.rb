class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :message
      t.integer :notice_type
      t.boolean :unread, default: true

      t.timestamps
    end
  end
end
