class User < ActiveRecord::Base
    has_many :reservations 
    has_many :hotels, through: :reservations 


  def self.main_menu 
    puts "\n\n\n     MAIN MENU\n\n"
    puts "To manage Reservations, Enter: 1"
    puts "To view avaialble Accomodations, Enter: 2"
    puts "To exit, Enter: 'exit' \n\n\n"
    u_input = gets.chomp.strip 
    case u_input 
    when "1" 
      Reservation.menu
    when "2" 
<<<<<<< HEAD
      Hotel.accomodations_search 
=======
      Hotel.accomodations_search
>>>>>>> 0a96660e9988e3818a859f50cffd040486d586ab
    when 'exit' 
      Cli.exit
    else 
      puts "\n\nPlease Enter a valid input"
      User.main_menu
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
      User.main_menu
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
    puts "Thank you #{first} for signing up for BOOKING: NEW YORK!!\n\nEnjoy your first trip!\n\n"
    User.main_menu
  end

end


