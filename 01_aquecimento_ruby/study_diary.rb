require_relative 'ui'
require_relative 'study_item'

def show_items
  study_items = StudyItem.all
  print_items_and_notify_if_empty(study_items)
end

def check_uncheck_item(items)
  return if items.empty?
  item_id = request_item_id
  clear
  item = StudyItem.get(item_id)
  item.check_uncheck if item
  show_items
end

def start
  clear
  puts welcome
  option = show_menu
  clear

  loop do
    case option
    when REGISTER
      data = request_new_study_item
      item = StudyItem.new(title: data[:title], category: data[:category])
      notify_success_registration(item)
    when VIEW
      show_items
    when SEARCH
      term = request_word_to_search
      clear
      found_items = StudyItem.search(term)
      print_items_and_notify_if_empty(found_items)
    when CHECK
      study_items = StudyItem.all
      print_items_and_notify_if_empty(study_items)
      check_uncheck_item(study_items)
    when EXIT
      say_thanks
      break
    else
      say_invalid_option
    end
    option = show_menu
    clear
  end
end
