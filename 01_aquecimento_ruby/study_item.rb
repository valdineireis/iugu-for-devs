class StudyItem
    attr_reader :id, :title, :category, :is_checked

    @@next_id = 1
    @@study_items = []

    def initialize(title:, category:)
        @id = @@next_id
        @title = title
        @category = category
        @is_checked = false

        @@next_id += 1
        @@study_items << self
    end

    def self.all
        @@study_items
    end

    def self.search(term)
        @@study_items.filter { |item| item.include?(term) }
    end

    def self.get(id)
        @@study_items.detect { |item| item.id == id }
    end

    def check_uncheck
        @is_checked = !@is_checked
    end

    def include?(query)
        title.include?(query) || category.include?(query)
    end

    def to_s
        "##{id} - #{title} - #{category}"
    end
end