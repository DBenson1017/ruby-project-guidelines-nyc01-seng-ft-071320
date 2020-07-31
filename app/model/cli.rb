class Cli

  def self.begin
    #system('rake db:migrate')
    #system('rake db:seed')
    puts "\n\n      A simple and easy way to book Accommodations\n\n"
    puts "             Enter either (log in) or (sign up)\n"
    puts "                    To Exit enter (exit)\n\n"
    u_response = gets.chomp.downcase.strip
    case u_response
    when 'log in'
      User.log_in
    when 'sign up'
      User.sign_up
    when 'exit'
      Cli.exit
    else
      puts "\n\n        Invalid input\n\n"
      Cli.begin
    end
  end

  def self.exit
    puts "\n\nThank you so much for using BOOKING!!\n\n"
  end


end