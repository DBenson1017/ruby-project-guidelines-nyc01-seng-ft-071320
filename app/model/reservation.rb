class Reservation < ActiveRecord::Base
    belongs_to :hotel
    belongs_to :user

  def self.reservations_menu
    puts "      RESERVATIONS\n\n"
    puts "To view all Reservations, Enter: 1"
    puts "To change an upcoming Reservation, Enter: 2"
    puts "To delete an upcoming Reservations, Enter: 3"
    puts "To book a new Reservation, Enter: 4\n\n"
    puts "To return to Main Menu ('5') to log off and Exit ('6')"
    user_input = gets.chomp.strip
    case user_input
    when "1" 
      if $current_user.reservations
        puts "\n\nHere are all your current reservations:\n\n"
        $current_user.hotels.each do |r|
          puts "Id: #{r.id}\nName: #{r.name}\nPrice: #{r.price}\nBeds: #{r.beds}\nGuest Count: #{r.guest_amount}\nNeighborhood: #{r.neighborhood}\n\n"
        end
        puts "Press anything to return to the Reservation Menu."
        any_key = gets 
        reservations_menu
      else
        puts "Uh oh! Looks like you don't have any Reservations currently. Here is the menu for avaliable Accomidations."
        ##### Take user to Accomidations Menu #####
      end
    when "2"
      if $current_user.reservations
        Reservation.reservation_update
      else
        puts "Uh oh! Looks like you don't have any Reservations currently. Here is the menu for avaliable Accomidations."
        ##### Take user to Accomidations Menu #####
      end
    when "3"
      if $current_user.reservations
        Reservation.reservation_delete
      else
        puts "Uh oh! Looks like you don't have any Reservations currently. Here is the menu for avaliable Accomidations."
        ##### Take user to Accomidations Menu #####
      end
    when "4"
      puts "Which Accomidation would you like to make a reservation for?\n\n"
      # Method to list all avaliable accomidations (Hotel class)
    when "5"
      User.main_menu
    when "6"
      Cli.exit
    else
      puts "Please enter a valid number\n\n"
      reservations_menu
    end
  end

  def self.reservation_delete
    puts "\nHere are all your upcoming Reservations:\n"
    $current_user.hotels.each do |r|
      puts "Id: #{r.id}\nName: #{r.name}\n\n"
    end
    
    puts "Plese enter by ('Id') which reservation you would like to delete."
    id_input = gets.chomp.strip
    id_input = Reservation.find_by(hotel_id: id_input)
    id_input.delete
    puts "     \nReservation deleted.\n\n"
    Reservation.reservations_menu
    
  end

end
