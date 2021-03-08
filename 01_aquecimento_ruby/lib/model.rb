require "sqlite3"

class Model
    DB_PATH = "db/study_diary.db"

    @@table_name = ''
    @@table_columns = ['id']

    def self.insert(hash_params)
        columns = []
        values = []
        hash_params.each do |key, value|
            columns << key
            values << value
        end

        sql = <<-SQL
            INSERT INTO #{@@table_name}(#{columns.join(',')}) 
            VALUES (#{columns.map { |_| '?' }.join(',') })
        SQL
        sql = sql.split.join " "

        begin
            db = SQLite3::Database.new DB_PATH
            db.execute(sql, values)
        rescue SQLite3::Exception => e
            puts 'Ocorreu um erro'
            puts e
        ensure
            db.close if db
        end
    end

    def self.find_all(hash = {})
        where = []
        values = []
        unless hash.empty?
            hash.each do |key, value|
                where << "#{key} LIKE ?"
                values << "%#{value}%"
            end
        end

        sql = "SELECT #{@@table_columns.join(',')} FROM #{@@table_name}"
        sql += " WHERE #{where.join(" OR ")}" unless hash.empty?

        begin
            db = SQLite3::Database.new DB_PATH
            items = db.execute(sql, values)
            return [] unless items
            items
        rescue SQLite3::Exception => e
            puts 'Ocorreu um erro'
            puts e
        ensure
            db.close if db
        end
    end

    def self.find_one(id)
        sql = "SELECT #{@@table_columns.join(',')} FROM #{@@table_name} WHERE id = ?"
        begin
            db = SQLite3::Database.new DB_PATH
            item = db.execute(sql, [id])
            return nil if item == nil || item.empty?
            item.first
        rescue SQLite3::Exception => e
            puts 'Ocorreu um erro'
            puts e
        ensure
            db.close if db
        end
    end

    def update(id, hash = {})
        items = []
        values = []
        unless hash.empty?
            hash.each do |key, value|
                items << "#{key} = ?"
                values << value
            end
        end

        sql = "UPDATE #{@@table_name} SET #{items.join(',')} WHERE id = ?"
        params = values + [@id]

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