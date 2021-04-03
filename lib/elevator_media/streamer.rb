

require 'json'
require 'http'
require 'rest_client'


# TDD is short for test-driven development. In simplest terms, test-driven means test first. The idea is that you write a very small test for a small part of a feature, and then you write the code that makes that test pass. Then you write another small test. So the verification development cycle has four main steps. First, we write the code. We write the full feature. We do all the coding. Second, we write the test. We try and define what would be successful code. And we use that to verify and validate that our code from step one is working correctly. Then, once we have that test code, we run it. We run the test code and see. If it doesn't pass, we go back and we work on steps one and two again, until we get a passing test. 
module ElevatorMedia
  class Streamer

    
# initializing our apis(Note that you can put them in aaplication.yml but this are not key token so it's ok)
    def initialize
      @chuckApi = 'http://api.icndb.com/jokes/random'
      @randomAdviceapi = 'https://api.adviceslip.com/advice'
    end
    
    def getContent(content_type)

        randomAdvice= self.randomAdvice()
        chuck = self.chuckNorris()
        
      if content_type == 'randomAdviceapi'

        information = "<html> <body> <div> 
        The Advice I can give you is : #{randomAdvice['slip']} 
        </div> </body> </html> "
        
      end
      
      if content_type == 'chuckApi'

        information = "<html> <body> <div> 
        The Chuck Norris joke of the day is: #{chuck['value']['joke']}  
        </div> </body> </html> "
        
      end
    
    end
    def randomAdvice()
     id = rand(1..20)
   
      advice = RestClient::Request.execute(method: :get, url: "api.adviceslip.com/advice", header: {})
      p advice
      return advice
    end

    def chuckNorris()
      id = rand(1..20)
   
      @j_chuck = RestClient::Request.execute(method: :get, url: "http://api.icndb.com/jokes/random", header: {})
      p @j_chuck
     
    end
  # in TDD,  this process expressed as red, green, refactor.  The idea is that you first write a failing test, and then you get your code to pass. And then after that, you clean up. So red is the failing test, green is the passing test, and refactor is the clean-up. That's why I wrote this small test.
    def getDetails

      Building.all.each do |building|
        building_id = building.id
      end
      Battery.all.each do |battery|
        battery_id = battery.id
      end
      Column.all.each do |column|
          column_id = column.id
      end
      Elevator.all.each do |elevator|
        elevator_id = elevator.id
      end
    end
  end 
end