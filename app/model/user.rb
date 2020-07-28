class User < ActiveRecord::Base
    has_many :reservations 
    has_many :hotels, through: :reservations 

    #update messages for ease of use 
  # @@user_instance = []
  def main_menu 
    puts "\n\n     MAIN MENU\n\n"
    puts "To manage your reservations, enter: 1"
    puts "To see avaialble accomodations, enter: 2"
    puts "To log out, enter: 'exit' \n\n"
    u_input = gets.chomp.strip 
    case u_input 
    when "1" 
      Reservation.reservations_menu
    when "2" 
      #go to hotels.all 
    when 'exit' 
      #log out method 
    else 
      puts "\n\nPlease enter a valid input"
      main_menu
    end
  end 

  def self.log_in
    puts "Please enter your email:"
    email_input = gets.chomp.strip
    puts "Please enter your password:"
    pw = gets.chomp.strip

    unless User.find_by(email: email_input, password: pw) then
      puts "Incorrect email/password"
      User.log_in
    else
      $current_user = User.find_by(email: email_input, password: pw)
      $current_user.main_menu
      
    end
  end
    
  def self.sign_up
      puts "Please input your first name:"
      first = gets.chomp.strip
      puts "Please input your last name:"
      last = gets.chomp.strip
      puts "Please input your email:" 
      user_email = gets.chomp.strip
      puts "Lastly, please create a password!"
      pw = gets.chomp.strip
      
      $current_user = User.create(first_name: first, last_name: last, email: user_email, password: pw)
      puts "Thank you #{first} for signing up for BOOKING: NEW YORK!!"
      puts "Enjoy your first trip!"
      puts " "
      #add way to validaite, after we create the Update methods in user 
      # method to take them to main menu
      main_menu
    end
    # def self.user_instance
    #   @@user_instance
    # end
  



end


