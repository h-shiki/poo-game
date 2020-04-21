class Game
    attr_accessor :human_player, :enemies, :ennemies_out, :ennemies_in_sight, :player_left
  
  
    def draw_ennemie(string)
      box = TTY::Box.frame( width: 100,align: :center, style: {fg: :bright_yellow, bg: :red, border: { fg: :bright_yellow, bg: :red }}) do 
        string
      end
      puts box
    end
    def draw_user(string)
      box = TTY::Box.frame( width: 100,align: :center, style: {fg: :blue, bg: :white, border: { fg: :blue, bg: :white }}) do 
        string
      end
      puts box
    end
  
    def draw_menu(string)
      box = TTY::Box.frame( width: 100,align: :center, style: {fg: :bright_yellow, bg: :blue, border: { fg: :bright_yellow, bg: :blue }}) do 
        string
      end
      puts box
    end
  
    def draw_ennemie_in_sight(string)
      box = TTY::Box.frame( width: 100,align: :center, style: {fg: :white, bg: :blue, border: { fg: :red, bg: :blue, }}) do 
        string
      end
      puts box
    end
  
    def draw_info_white(string)
      box = TTY::Box.frame( width: 100,align: :center, style: {fg: :bright_white, bg: :green, border: { fg: :bright_white, bg: :green }}) do 
        string
      end
      puts box
    end
  
    def draw_info_red(string)
      box = TTY::Box.frame( width: 100,align: :center, style: {fg: :red, bg: :green, border: { fg: :red, bg: :green }}) do 
        string
      end
      puts box
    end
  
  
  
  
    
  
    def initialize(human_player_name)
      @ennemies=[]
      @ennemies_in_sight=[]
      @name=human_player_name
      @player_left=20
      @player_left.times do |i|
        @ennemies << "player"+(i.to_s)
      end
      # @ennemies=["bob", "bobby", "bobette", "bobo", "boba", "bobu", "bobi", "babo", "baba", "babu"]
      @ennemies_out=[]
      @user = HumanPlayer.new(@name)
      draw_info_white(@user.show_state)
      # @ennemies.each_with_index do |ennemie, i|
      #   @ennemies_out << Player.new(ennemie)
      #   @ennemies_out[i].show_state
      #   puts
      # end
    end
  
    def kill_player(player)
      @ennemies_in_sight.each_with_index do |ennemie, i|
        if @ennemies_in_sight[i]==player
          @ennemies_in_sight.delete_at(i)
        end
      end
      @player_left-=1
    end
  
    def is_still_ongoing?
      if @user.life_points >0 && @player_left >0
        return true
      else
        return false
      end
    end
  
    def new_players_in_sight
      dice=rand(1..6)
      if @ennemies_in_sight.count == @player_left
                    # box = TTY::Box.error("Tous les joueurs sont déjà en vue")
                    # puts box
                    # # puts "Tous les joueurs sont déjà en vue"
        draw_ennemie("Tous les joueurs sont déjà en vue")
      elsif dice == 1
                      # puts "add zero"
                      # box = TTY::Box.error("Add zero ennemie")
                      # puts box
        draw_ennemie("Add zero ennemie")
  
  
      elsif dice >1 && dice <=4
                    # puts "add one"
                    # box = TTY::Box.error("Add one ennemie")
                    # puts box
        draw_ennemie("Add one ennemie")
        1.times do
          @ennemies_in_sight << Player.new(@ennemies[0])
          @ennemies.shift
        end
      elsif dice >=5
                        # box = TTY::Box.error("Add two ennemies")
                        # puts box
        draw_ennemie("Add two ennemies")
        2.times do
          @ennemies_in_sight << Player.new(@ennemies[0])
          @ennemies.shift
        end
        # puts "add two"
      end
    end
  
  
    def show_players
      draw_info_white(@user.show_state) 
      draw_info_red("Il reste #{@ennemies.count} joueur(s)")
    end
  
    def menu
  
      # puts
      # puts "Quelle action veux-tu effectuer ?"
      # puts
      # puts "a - chercher une meilleure arme"
      # puts "s - chercher à se soigner "
      # puts
      # puts "attaquer un joueur en vue :"
      draw_menu("Quelle action veux-tu effectuer ?")
      draw_menu("a - chercher une meilleure arme")
      draw_menu("s - chercher à se soigner ")
      draw_menu("attaquer un joueur en vue :")
      
      @ennemies_in_sight.each_with_index do |ennemie, i|
        str=""
        str += i.to_s 
        str += " - "
        str += "#{@ennemies_in_sight[i].show_state}"
        draw_ennemie_in_sight(str)
        # print i
        # print " - "
        # print "#{@ennemies_in_sight[i].show_state}"
      end
  
      draw_info_white(@user.show_state)
      
      draw_info_red("les ennemies peuvent vous infliger #{@ennemies_in_sight.count*6} points de dégats au maximum")
    end
  
    def menu_choice(choice)
      @choice=choice
      case choice
      when "a"
        @user.search_weapon
      when "s"
        @user.search_health_pack
      when ""
        
      else 
        puts choice
        if @user.attacks(@ennemies_in_sight[choice.to_i])<=0
          kill_player(@ennemies_in_sight[choice.to_i])
        end
        
      end
    end
  
    def ennemies_attack
      @ennemies_in_sight.each_with_index do |ennemie, i|
        ennemie.attacks(@user)
      end
    end
  
    def end
      if @user.life_points >0 && @ennemies.count ==0
        puts "~"*100
        puts "~"*100
        puts "BRAVO tu as gagné"
        puts "~"*100
        puts "~"*100
      else
        puts "~"*100
        puts "~"*100
        puts "LOOSER"
        puts "~"*100
        puts "~"*100
      end
    end
  
  
  end
  
  
  
  
  
  
  
  
  
  
  
  
  