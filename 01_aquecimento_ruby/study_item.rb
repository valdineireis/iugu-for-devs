class StudyItem

    attr_reader :id, :title, :category

    @@next_id = 1
    @@study_items = []

    def initialize(title:, category:)
        @id = @@next_id
        @title = title
        @category = category

        @@next_id += 1
        @@study_items << self
    end

    def self.all
        @@study_items
    end

    def include?(query)
        title.include?(query) || category.include?(query)
    end

    def self.search(term)
        @@study_items.filter { |item| item.include?(term) }
    end

    def to_s
        "##{id} - #{title} - #{category}"
    end
end