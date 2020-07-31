class Cli



  def self.begin

    puts "A simple and easy way to book Accomodations in New York City\n\n"

    puts "     To LOG IN type 'log in' to SIGN UP type 'sign up'\n\n"
    u_response = gets.chomp.downcase.strip
    case u_response
    when 'log in'
      User.log_in
    when 'sign up'
      User.sign_up
    else
      puts "\n\n        Invalid input\n\n"
      Cli.begin
    end
  end

  def self.exit
    puts "\n\nThank you so much for using BOOKING: NEW YORK!!\n\n"
  end


end