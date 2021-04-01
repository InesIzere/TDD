require 'json'
require 'http'
require 'rest_client'

module ElevatorMedia
  class Streamer

    

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
    def self.getAllElevators
      Elevator.all.each do |elevator|
        elevator_id = elevator.id
    end
  end
  def self.getAllColumns
    Column.all.each do |column|
      column_id = column.id
  end
 end
  end 
end