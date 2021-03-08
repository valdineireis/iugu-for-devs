require_relative 'model'

class StudyItem < Model

    @@table_name = 'Study_Items'
    @@table_columns = ['id', 'title', 'category', 'is_checked']

    attr_reader :id, :title, :category, :is_checked

    def initialize(id: 0, title:, category:, is_checked: 0)
        @id = id
        @title = title
        @category = category
        @is_checked = is_checked
    end

    def self.register(title:, category:)
        is_checked = 0
        self.insert({title: title, category: category, is_checked: is_checked})
        self.new(title: title, category: category, is_checked: is_checked)
    end

    def self.all
        study_items_obj = []
        self.find_all.each do |item|
            study_items_obj << self.new(id: item[0], title: item[1], category: item[2], is_checked: item[3])
        end
        study_items_obj
    end

    def self.search(term)
        study_items_obj = []
        study_items = self.find_all({title: term, category: term})
        study_items.each do |item|
            study_items_obj << self.new(id: item[0], title: item[1], category: item[2], is_checked: item[3])
        end
        study_items_obj
    end

    def self.find(id)
        item = self.find_one(id)
        self.new(id: item[0], title: item[1], category: item[2], is_checked: item[3]) if item
    end

    def check_uncheck
        @is_checked = @is_checked == 1 ? 0 : 1
        update(@id, {is_checked: @is_checked})
    end

    def include?(query)
        title.include?(query) || category.include?(query)
    end

    def to_s
        "##{id} - #{title} - #{category}"
    end
end