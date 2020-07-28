class Cli



  def self.begin
    puts "Welcome to BOOKING: NEW YORK"
    puts " "
    puts "A simple and easy way to book accomidations in New York City"
    puts " "
    puts "To login in type 'log in' to sign up type 'sign up'"
    u_response = gets.chomp.downcase
    case u_response
    when 'log in'
      #send to the log in method in User
    when 'sign up'
      #send to sign up method in User
    else
      User.begin
    end

  end


end