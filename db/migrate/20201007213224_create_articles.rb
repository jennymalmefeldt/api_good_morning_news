class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :teaser
      t.text :text

      t.timestamps
    end
  end
end
