class Cli



  def self.begin
    puts "\nWelcome to BOOKING: NEW YORK\n\n"
    # puts " "
    puts "A simple and easy way to book accomidations in New York City\n\n"
    # puts " "
    puts "To login in type 'log in' to sign up type 'sign up'\n\n"
    u_response = gets.chomp.downcase.strip
    case u_response
    when 'log in'
      User.log_in
    when 'sign up'
      User.sign_up
    else
      puts "**********************"
      puts "*****Invalid input****"
      puts "**********************\n\n"
      Cli.begin
    end
  end


end