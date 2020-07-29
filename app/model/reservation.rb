class Reservation < ActiveRecord::Base
    belongs_to :hotel
    belongs_to :user

  def self.menu
    puts "      RESERVATIONS\n\n"
    puts "To view all Reservations, Enter: 1"
    puts "To change an upcoming Reservation, Enter: 2"
    puts "To delete an upcoming Reservations, Enter: 3"
    puts "To book a new Reservation, Enter: 4\n\n"
    puts "To return to Main Menu ('5') to log off and Exit ('6')"
    user_input = gets.chomp.strip
    case user_input
    when "1" 
      $current_user.reservations != [] ? Reservation.reservation_list : Reservation.uh_oh
    when "2"
      $current_user.reservations != [] ? Reservation.reservation_update : Reservation.uh_oh
    when "3"
      $current_user.reservations != [] ? Reservation.reservation_delete : Reservation.uh_oh
    when "4"
      Reservation.create_new
    when "5"
      User.main_menu
    when "6"
      Cli.exit
    else
      puts "Please enter a valid number\n\n"
    .menu
    end
  end

    #################### FIX VIEW FOR PAST/UPCOMING  &  INCLUDE #OF NIGHTS ###############
  def self.reservation_list
    puts "\n\nHere are all your past & upcoming Reservations:\n\n"
    $current_user.hotels.reload.each do |r|
      puts "Id: #{r.id}\nName: #{r.name}\nPrice: #{r.price}\nBeds: #{r.beds}\nGuest Count: #{r.guest_amount}\nNeighborhood: #{r.neighborhood}\n\n"
    end

    puts "Press anything to return to the Reservation Menu."
    any_key = gets 
    Reservation.menu
  end

  def self.reservation_delete
    puts "\nHere are all your upcoming Reservations:\n"
    $current_user.hotels.each do |r|
      puts "Id: #{r.id}\nName: #{r.name}\n\n"
    end
    puts "Plese enter by ('Id') which Reservation you would like to delete."
    id_input = gets.chomp.strip
    res_to_dlt = Reservation.find_by(hotel_id: id_input.to_i)
    res_to_dlt.destroy
    #binding.pry
    puts "     \nReservation deleted.\n\n"
    Reservation.menu
  end
  
  def self.reservation_update
      puts "\nHere are all your upcoming Reservations:\n"
      $current_user.hotels.each do |r|
        puts "Id: #{r.id}\nName: #{r.name}\n\n"
      end
      puts "Plese enter by ('Id') which Reservation you would like to change."
      id_input = gets.chomp.strip
      chosen_accom = Hotel.find_by(id: id_input.to_i)
      puts "The guest count is currently #{chosen_accom.guest_amount}.\nPlease input the number of guests you would like to change it to."
      new_guest_total = gets.chomp.strip
      chosen_accom.guest_amount = new_guest_total
      chosen_accom.save
      puts "\n\nYour change has been saved.\nPress any key to return to the Reservations Menu.\n"
      any_key = gets
      Reservation.menu
    end

    def self.create_new
      puts "\n\nHere is a list of all avaliable Accomidations:\n\n"
      #### METHOD FROM HOTEL CLASS FOR ALL ACCOMIDATIONS #####
      puts "\nPlease enter the (id) of the Accomidation you would like to make a reservation for.\n"
      h_id = gets.chomp.strip
      if Hotel.all.include?(h_id.to_i)
        Reservation.create(user_id: $current_user.id, hotel_id: h_id.to_i)
      else
        puts "\n\nUh oh. It seems like you input an incorrect (id). Please try again.\n\n"
        Reservation.create_new
      end
    end
  
    def self.uh_oh
    puts "\n\nUh oh!\nLooks like you don't have any Reservations currently.\nEnter any key to continue to the menu for avaliable Accomidations.\n\n"
    any_key = gets
      ##### TAKE USER TO ACCOMIDATIONS MENU #####
  end

  

end
