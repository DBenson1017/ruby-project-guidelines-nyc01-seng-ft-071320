class Reservation < ActiveRecord::Base
    belongs_to :hotel
    belongs_to :user

  def self.menu
    puts "      RESERVATIONS\n\n"
    puts "To list all Reservations, Enter: 1"
    puts "To change Date on upcoming Reservations, Enter: 2"
    puts "To delete upcoming Reservations, Enter: 3"
    puts "To book new Reservation, Enter: 4\n\n"
    puts "To return to Main Menu ('5') to log off and Exit ('6')"
    user_input = gets.chomp.strip
    case user_input
    when "1" 
      $current_user.reservations != [] ? Reservation.reservation_list : Reservation.uh_oh
    when "2"
      $current_user.reservations != [] ? Reservation.update_date : Reservation.uh_oh
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
    $current_user.reservations.reload.each do |r|
      puts "Id: #{r.id}\nName: #{r.hotel.name}\n\n"
    end
  end
  

  def self.reservation_delete
    puts "\nHere are all your upcoming Reservations:\n"
    Reservation.reservations_list_by_name_and_id
    puts "Plese enter by ('Id') which Reservation you would like to delete."
    res_id = gets.chomp.strip
    if Reservation.all.ids.include?(res_id.to_i)
      res_to_dlt = Reservation.find_by(id: res_id.to_i)
      res_to_dlt.destroy
      puts "     \nReservation deleted.\n\n"
      Reservation.menu
    else
      puts "\n\nUh oh. It seems like you input an incorrect (id). Would you like to try again? (Y/N)\n\n"
      user_input = gets.chomp.strip
      user_input == "Y" ? Reservation.create_new : Reservation.menu
    end
  end
    

  def self.valid_start_date
    puts "\nPlease input a START date formated: YYYY-MM-DD\n"
    @new_start_date = gets.chomp.strip
    begin  
      Date.parse(@new_start_date)
    rescue ArgumentError
      puts "Invalid Date. Please try again"
      Reservation.valid_start_date
    end
    upcoming = Date.parse(@new_start_date) <=> Date.today 
    if upcoming == -1 || upcoming == 0
      puts "Invalid Date. START date must be in the future. Please try again"  
      Reservation.valid_start_date
    end
  end
  def self.valid_end_date
    puts "\nPlease input a END date formated: YYYY-MM-DD\n"
    @new_end_date = gets.chomp.strip
    begin  
      Date.parse(@new_end_date)
    rescue ArgumentError
      puts "Invalid Date. Please try again"
      Reservation.valid_end_date
    end
    upcoming = Date.parse(@new_end_date) <=> Date.today 
    after_start = Date.parse(@new_end_date) <=> Date.parse(@new_start_date)
    if upcoming == -1 || upcoming == 0
      puts "Invalid Date. START date must be in the future."
      Reservation.valid_end_date
    elsif after_start == -1 || after_start == 0
      puts "END Date must be after START date."
      Reservation.valid_end_date
    end
  end


  def self.update_date
    puts "\nHere are all your upcoming Reservations:\n"
    Reservation.reservations_list_by_name_and_id
    puts "Plese Enter by ('id') which Reservation you would like to change."
    res_id_input = gets.chomp.strip
    chosen_reservation = Reservation.find_by(id: res_id_input.to_i, user_id: $current_user.id)
    puts "\nYour current Dates for this Reservation are #{chosen_reservation.start_date.strftime('%a %d %b %Y')} - #{chosen_reservation.end_date.strftime('%a %d %b %Y')}\n\n"
    Reservation.valid_start_date
    Reservation.valid_end_date
    chosen_reservation.start_date = DateTime.parse(@new_start_date)
    chosen_reservation.end_date = DateTime.parse(@new_end_date)
    chosen_reservation.save
    puts "\n\nYour changes have been saved.\nEnter any key to return to the Reservations Menu.\n"
    any_key = gets
    Reservation.menu
  end


  def self.create_new
    puts "\n\nHere is a list of all avaliable Accomidations:\n\n"
    Hotel.all_accomidations
    puts "\nPlease Enter the (id) of the Accomidation you would like to make a reservation for.\n"
    h_id = gets.chomp.strip
    Reservation.valid_start_date
    Reservation.valid_end_date
    if Hotel.all.ids.include?(h_id.to_i)
      Reservation.create(user_id: $current_user.id, hotel_id: h_id, start_date: DateTime.parse(@new_start_date), end_date: DateTime.parse(@new_end_date))
      puts "\nYour Reservation has been made!\nEnter any key to return to Reservations Menu."
      any = gets
      Reservation.menu
    else
      puts "\n\nUh oh. It seems like you input an incorrect (id). Would you like to try again? (Y/N)\n\n"
      user_input = gets.chomp.strip
      user_input == "Y" ? Reservation.create_new : Reservation.menu
    end
  end
  

  def self.uh_oh
    puts "\n\nUh oh!\nLooks like you don't have any Reservations currently.\nEnter any key to continue to Accomidations Menu.\n\n"
    any_key = gets
    Hotel.accomodations_search
  end

  

end


# def self.all_accomidations
#   Hotel.all.each do |r|
#   puts "Id: #{r.id}\nName: #{r.name}\nPrice: #{r.price}\nBeds: #{r.beds}\nGuest Count: #{r.guest_amount}\nNeighborhood: #{r.neighborhood}\n\n"
#   end
# end


