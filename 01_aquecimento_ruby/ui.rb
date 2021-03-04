REGISTER = 1
VIEW     = 2
SEARCH   = 3
EXIT     = 4

def welcome
    'Bem-vindo ao Diário de Estudos, seu companheiro para estudar!'
end

def show_menu
    puts '----------------------------------'
    puts "[#{REGISTER}] Cadastrar um item para estudar"
    puts "[#{VIEW}] Ver todos os itens cadastrados"
    puts "[#{SEARCH}] Buscar um item de estudo"
    puts "[#{EXIT}] Sair"
    print 'Escolha uma opção: '
    gets.to_i
end

def request_new_study_item
    print 'Digite o título do seu item de estudo: '
    title = gets.chomp
    clear
    print 'Digite a categoria do seu item de estudo: '
    category = gets.chomp
    clear
    { title: title, category: category }
end

def notify_success_registration(study_item)
    puts "Item '#{study_item.title}' da categoria '#{study_item.category}' cadastrado com sucesso!"
end

def say_thanks
    puts 'Obrigado por usar o Diário de Estudos'
end

def say_invalid_option
    puts 'Opção inválida'
end

def notify_if_empty(collection)
    puts 'Nenhum item encontrado' if collection.empty?
end

def request_word_to_search
    print 'Digite uma palavra para procurar: '
    gets.chomp
end

def print_items(collection)
    collection.each do |item|
        puts item
    end
end

def clear
    system('clear')
end
