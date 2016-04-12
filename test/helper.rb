config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(config['sqlite3'])
ActiveRecord::Schema.define(version: 0) do
  begin
  drop_table :posts, :force => true
  rescue
    #dont really care if the tables are not dropped
  end

  create_table(:posts, :force => true) do |t|
    t.string :name
    t.string :title
    t.text :content
    t.integer :votes
    t.timestamps null: false
  end
end

class Post < ActiveRecord::Base

end

posts = []
posts << Post.new(name: "first post", title: "This is the first post", content: "I am a very good first post!", votes: 1)
posts << Post.new(name: "second post", title: "This is the second post", content: "I am the best post!", votes: 7)
posts.each { |p| p.save! }
