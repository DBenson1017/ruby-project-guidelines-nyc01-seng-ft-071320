class Cli



  def self.begin
    puts "Welcome to BOOKING: NEW YORK"
    puts " "
    puts "A simple and easy way to book accomidations in New York City"
    puts " "
    puts "To login in type 'log in' to sign up type 'sign up'"
    u_response = gets.chomp.downcase.strip
    case u_response
    when 'log in'
      User.log_in
    when 'sign up'
      User.sign_up
    else
      Cli.begin
    end

  end


  ##############METHODS TO ADD 

end