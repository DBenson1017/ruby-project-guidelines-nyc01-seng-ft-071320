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
      Reservation.menu
    end
  end

    
  def self.reservation_list
    puts "\n\nHere are all your Reservations:\n\n"
    $current_user.reservations.reload.each do |r|
      puts "Id: #{r.hotel.id}\nName: #{r.hotel.name}\nPrice: #{r.hotel.price}\nBeds: #{r.hotel.beds}\nGuest Count: #{r.hotel.guest_amount}\nNeighborhood: #{r.hotel.neighborhood}\nDates:#{r.start_date.strftime('%a %d %b %Y')} - #{r.end_date.strftime('%a %d %b %Y')}\n\n"
    end
    puts "Press anything to return to the Reservation Menu."
    any_key = gets 
    Reservation.menu
  end
  def self.reservations_list_by_name_and_id
    $current_user.hotels.each do |r|
      puts "Id: #{r.id}\nName: #{r.name}\n\n"
    end
  end
  

  def self.reservation_delete
    puts "\nHere are all your upcoming Reservations:\n"
    Reservation.reservations_list_by_name_and_id
    puts "Plese enter by ('Id') which Reservation you would like to delete."
    id_input = gets.chomp.strip
    res_to_dlt = Reservation.find_by(hotel_id: id_input.to_i)
    res_to_dlt.destroy
    puts "     \nReservation deleted.\n\n"
    Reservation.menu
  end
  
  def self.reservation_update
      puts "\nHere are all your upcoming Reservations:\n"
      Reservation.reservations_list_by_name_and_id
      puts "\nIf you would like to change the dates of one of these Reservations Enter: 1\nIf you would like to change the guest count for one of these Reservations Enter: 2\n\n"
      user_choice = gets.chomp.strip
      case user_choice
      when "1"
        Reservation.update_date
      when "2"
        Reservation.update_guest_count
      else
        puts "It appears you made an invalid input"
        Reservation.menu
      end
    end

    # def self.update_guest_count
    #   puts "Plese enter by ('Id') which Reservation you would like to change."
    #   id_input = gets.chomp.strip
    #   chosen_accom = Hotel.find_by(id: id_input.to_i)  
    #   puts "The guest count is currently #{chosen_accom.guest_amount}.\nPlease input the number of guests you would like to change it to."
    #   new_guest_total = gets.chomp.strip
    #   chosen_accom.guest_amount = new_guest_total
    #   chosen_accom.save
    #   puts "\n\nYour change has been saved.\nPress any key to return to the Reservations Menu.\n"
    #   any_key = gets
    #   Reservation.menu
    # end
    def self.update_date
      puts "Plese enter by ('Id') which Reservation you would like to change."
      id_input = gets.chomp.strip

      chosen_reservation = Reservation.find_by(hotel_id: id_input.to_i, user_id: $current_user.id) 
      puts "\nYour current dates for this Reservation are #{chosen_reservation.start_date.strftime('%a %d %b %Y')} - #{chosen_reservation.end_date.strftime('%a %d %b %Y')}\n\n"
      puts "\nPlease input a new START date formated: YYYY-MM-DD\n"
      new_start_date = gets.chomp.strip
      puts "\nPlease input a new END date formated: YYYY-MM-DD\n"
      new_end_date = gets.chomp.strip
      chosen_reservation.start_date = DateTime.parse(new_start_date)
      chosen_reservation.end_date = DateTime.parse(new_end_date)
      chosen_reservation.save
      puts "\n\nYour changes have been saved.\nPress any key to return to the Reservations Menu.\n"
      a1
      Reservation.menu
    end

    def self.create_new
      puts "\n\nHere is a list of all avaliable Accomidations:\n\n"
      Hotel.all_accomidations
      puts "\nPlease enter the (id) of the Accomidation you would like to make a reservation for.\n"
      h_id = gets.chomp.strip
      puts "Please enter the date you would like to begin your Reservation formatted START: YYYY-MM-DD"
      s_date = gets.chomp.strip
      puts "Now please enter the date you would like to end your Reservation on formated END: YYYY-MM-DD"
      e_date = gets.chomp.strip
      if Hotel.all.ids.include?(h_id.to_i)
        Reservation.create(user_id: $current_user.id, hotel_id: h_id, start_date: DateTime.parse(s_date), end_date: DateTime.parse(e_date))
        puts "\nYour Reservation has been made!"
        Reservation.menu
      else
        puts "\n\nUh oh. It seems like you input an incorrect (id). Would you like to try again? (Y/N)\n\n"
        user_input = gets.chomp.strip
        user_input == "Y" ? Reservation.create_new : Reservation.menu
      end
    end
  
    def self.uh_oh
      puts "\n\nUh oh!\nLooks like you don't have any Reservations currently.\nEnter any key to continue to the menu for avaliable Accomidations.\n\n"
      any_key = gets
      Hotel.menu
    end

  

end



   # def self.all_accomidations
    #     Hotel.all.each do |r|
    #         puts "Id: #{r.id}\nName: #{r.name}\nPrice: #{r.price}\nBeds: #{r.beds}\nGuest Count: #{r.guest_amount}\nNeighborhood: #{r.neighborhood}\n\n"
    #       end

    # end
