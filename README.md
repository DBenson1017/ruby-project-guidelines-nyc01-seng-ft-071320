# Description 

Booker NYC is an app that allows users to search and book accomodations in the NYC area. The app is built around three Ruby classes, a database pulled from an API of AirBnB listings, and CLI commands for user input. 

The Ruby classes are User, Hotel, and Reservation. In this model users and hotels are joined together in many_to_many relationshuos through the Reservation class. Reservatations contain User and Hotel IDs, as well as a start and end date. 

The database we use is seeded with real accomodation information through an API subscritpion. Users are able to create profiles with an email and password, and then "book" accomodations by creating new instances of our Reservation class. 

Users are able to login, and through the Hotel class, search our database for accomodations based on the neighbood name, amount of beds, guest capacity, or price. Once they find the right accomodation, a menu of prompts collects their start and end date, and saves their new reservation to the database. From the main menu, users are able to view their reservations, and subsequently edit or delete records attached to their User ID. 


# Install Instructions 

Anyone who pulls the Booker NYC file down from GitHub will be able to open and read the app code in a text editor. In order to use the app, users will need to subscribe to the seeding API. Users can do this by: 
  Navigating to https://rapidapi.com/WebDataHub.com/api/Airbnb.com
  Subscirbing to the monthly plan that fits their needs. 
  Obtaining an access key through their subscription. 
  Saving a new .env file at the top level of the Booker NYC directory with a single line of code that sets airbnb_key = 'their new access key.'

# Contributors Guide 

Contributions and pull requests are welcome through GitHub. In order to experiment with Booker NYC please follow the directions above for new users to acccess the AirBnB API. Contributors and users alike will need subscriptions to the API in order for the app to work. 


# License 












# Module One Final Project Guidelines

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, we'll be building a Command Line database application.

## Project Requirements

### Option One - Data Analytics Project

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have at minimum three models including one join model. This means you must have a many-to-many relationship.
3. You should seed your database using data that you collect either from a CSV, a website by scraping, or an API.
4. Your models should have methods that answer interesting questions about the data. For example, if you've collected info about movie reviews, what is the most popular movie? What movie has the most reviews?
5. You should provide a CLI to display the return values of your interesting methods.  
6. Use good OO design patterns. You should have separate classes for your models and CLI interface.

  **Resource:** [Easy Access APIs](https://github.com/learn-co-curriculum/easy-access-apis)

### Option Two - Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate classes for your models and CLI interface.

### Brainstorming and Proposing a Project Idea

Projects need to be approved prior to launching into them, so take some time to brainstorm project options that will fulfill the requirements above.  You must have a minimum of four [user stories](https://en.wikipedia.org/wiki/User_story) to help explain how a user will interact with your app.  A user story should follow the general structure of `"As a <role>, I want <goal/desire> so that <benefit>"`. For example, if we were creating an app to randomly choose nearby restaurants on Yelp, we might write:

* As a user, I want to be able to enter my name to retrieve my records
* As a user, I want to enter a location and be given a random nearby restaurant suggestion
* As a user, I should be able to reject a suggestion and not see that restaurant suggestion again
* As a user, I want to be able to save to and retrieve a list of favorite restaurant suggestions

## Instructions

1. Fork and clone this repository.
2. Build your application. Make sure to commit early and commit often. Commit messages should be meaningful (clearly describe what you're doing in the commit) and accurate (there should be nothing in the commit that doesn't match the description in the commit message). Good rule of thumb is to commit every 3-7 mins of actual coding time. Most of your commits should have under 15 lines of code and a 2 line commit is perfectly acceptable.
3. Make sure to create a good README.md with a short description, install instructions, a contributor's guide and a link to the license for your code.
4. Make sure your project checks off each of the above requirements.
5. Prepare a video demo (narration helps!) describing how a user would interact with your working project.
    * The video should:
      - Have an overview of your project. (2 minutes max)
6. Prepare a presentation to follow your video. (3 minutes max)
    * Your presentation should:
      - Describe something you struggled to build, and show us how you ultimately implemented it in your code.
      - Discuss 3 things you learned in the process of working on this project.
      - Address what, if anything, you would change or add to what you have today.
      - Present any code you would like to highlight.   
7. *OPTIONAL, BUT RECOMMENDED*: Write a blog post about the project and process.

---
### Common Questions:
- How do I turn off my SQL logger?
```ruby
# in config/environment.rb add this line:
ActiveRecord::Base.logger = nil
```
