require_relative 'ui'
require_relative 'study_item'

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
    print_items(study_items)
    notify_if_empty(study_items)
  when SEARCH
    term = request_word_to_search
    clear
    found_items = StudyItem.search(term)
    print_items(found_items)
    notify_if_empty(found_items)
  when EXIT
    say_thanks
    break
  else
    say_invalid_option
  end
  option = show_menu
  clear
end
