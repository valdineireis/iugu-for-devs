require_relative 'ui'
require_relative 'study_item'

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
      study_items = StudyItem.all
      print_items_and_notify_if_empty(study_items)
    when SEARCH
      term = request_word_to_search
      clear
      found_items = StudyItem.search(term)
      print_items_and_notify_if_empty(found_items)
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
