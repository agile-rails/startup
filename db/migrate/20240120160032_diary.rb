class Diary < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.string   :title
      t.text     :body
      t.datetime :time_begin
      t.integer  :duration
      t.text     :search
      t.boolean  :closed, default: true
      t.integer  :ar_user_id

      t.timestamps

      t.index :ar_user_id
    end

  end
end
