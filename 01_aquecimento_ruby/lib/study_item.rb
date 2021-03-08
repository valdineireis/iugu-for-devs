require "sqlite3"

class StudyItem

    DB_PATH = "db/study_diary.db"

    attr_reader :id, :title, :category, :is_checked

    def initialize(id: 0, title:, category:, is_checked: 0)
        @id = id
        @title = title
        @category = category
        @is_checked = is_checked
    end

    def self.register(title:, category:)
        is_checked = 0
        self.execute_query("INSERT INTO Study_Items(TITLE, CATEGORY, IS_CHECKED) VALUES (?, ?, ?)", [title, category, is_checked])
        self.new(title: title, category: category, is_checked: is_checked)
    end

    def self.all
        study_items_obj = []
        study_items = self.execute_query("SELECT id, title, category, is_checked FROM Study_Items", [])
        study_items.each do |item|
            study_items_obj << self.new(id: item[0], title: item[1], category: item[2], is_checked: item[3])
        end
        study_items_obj
    end

    def self.search(term)
        study_items_obj = []
        study_items = self.execute_query("SELECT id, title, category, is_checked FROM Study_Items WHERE title LIKE ? OR category LIKE ?", ["%#{term}%", "%#{term}%"])
        study_items.each do |item|
            study_items_obj << self.new(id: item[0], title: item[1], category: item[2], is_checked: item[3])
        end
        study_items_obj
    end

    def self.find(id)
        item = self.execute_query("SELECT id, title, category, is_checked FROM Study_Items WHERE id = ?", [id])
        item = item.first
        self.new(id: item[0], title: item[1], category: item[2], is_checked: item[3]) if item
    end

    def check_uncheck
        @is_checked = @is_checked == 1 ? 0 : 1
        begin
            db = SQLite3::Database.new DB_PATH
            db.execute("UPDATE Study_Items SET is_checked = ? WHERE id = ?", [@is_checked, @id])
        rescue SQLite3::Exception => e
            puts 'Ocorreu um erro'
            puts e
        ensure
            db.close if db
        end
    end

    def include?(query)
        title.include?(query) || category.include?(query)
    end

    def to_s
        "##{id} - #{title} - #{category}"
    end

    private

    def self.execute_query(sql, params)
        begin
            db = SQLite3::Database.new DB_PATH
            db.execute(sql, params)
        rescue SQLite3::Exception => e
            puts 'Ocorreu um erro'
            puts e
        ensure
            db.close if db
        end
    end
end