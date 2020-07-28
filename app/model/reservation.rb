class Reservation < ActiveRecord::Base
    belongs_to :hotel
    belongs_to :user

  def self.reservations_menu
    puts "      RESERVATIONS\n\n"
    puts "To view all Reservations, Enter: 1"
    puts "To view past Reservations, Enter: 2"
    puts "To view or change upcoming Reservations, Enter: 3"
    puts "To book a new Reservation, Enter: 4\n\n"
    puts "To return to Main Menu ('5') to log off and Exit ('6')"
    user_input = gets.chomp.strip
    case user_input
    when "1"
      $current_user.hotels
    when "2"
      # Write method to view past reservations
    when "3"
      # Method to update/delete reservations
    when "4"
      puts "Which Accomidation would you like to make a reservation for?\n\n"
      # Method to list all avaliable accomidations (Hotel class)
    when "5"
      main_menu
    when "6"
      # Exit method
    else
      puts "Please enter a valid number\n\n"
      reservations_menu
    end
  end


end
