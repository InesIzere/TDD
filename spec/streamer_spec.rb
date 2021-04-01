require './lib/elevator_media/streamer.rb'
require 'json'
require 'net/http'
require 'spec_helper'
require 'rails_helper'

describe ElevatorMedia::Streamer do
    let!(:streamer){ElevatorMedia::Streamer.new}
    
  
   describe "The api Advice" do
     
     it "If an advice slip is found with the corresponding{id}, a slip object is returned." do
      
      Daily_Advice= 
       {
        "slip": {
            "id": 35,
            "advice": "Only those who attempt the impossible can achieve the absurd."
        }
       }
    
             result = JSON.parse(streamer.randomAdvice) 
                 expect(result).to_not eq(nil)
                expect(result).to have_key('slip')
                # expect(result["slip"]).to eq("advice")
         p result
     end
   end

  
   describe "The api for Chuck Noris" do
     
    it "If a Joke  is found with the corresponding{id}, a joke object is returned." do
     
     Daily_Joke= 
     {
      "type": "success",
      "value": {
          "id": 472,
          "joke": "When Chuck Norris is web surfing websites get the message &quot;Warning: Internet Explorer has deemed this user to be malicious or dangerous. Proceed?&quot;.",
          
      }
  }
            response = JSON.parse(streamer.chuckNorris) 
                expect(response).to_not eq(nil)
                expect(response["type"]).to eq("success")
        p response
    end
  end
  describe "Get all elevators" do
    it "This should query all the elevators" do
      expect(Elevator).to receive(:all) {[]}
      ElevatorMedia::Streamer.getAllElevators
    end
  end

  describe "Get all Columns" do
    it "This should query all the columns" do
      expect(Column).to receive(:all) {[]}
      ElevatorMedia::Streamer.getAllColumns
    end
  end

  
#   describe QuotesController, :type => :controller do
#     let(:quotes){Quote.all}
#     describe'GET index' do
#       it 'assign  all Quotes to @Quotes' do

#         get :submission
#         expect(assigns['quotes']).to eq(quotes)
#       end
#     end 
#   end   

 end

# let(:quotes){Quote.all}
RSpec.describe QuotesController, :type => :controller do

  describe "GET submission from quote controller" do
      it "get submission and return a successful response" do
          get :index
          expect(response).to be_successful
      end
      it "get submission and return 200 status" do
          get :index
          expect(response.status).to eq(200)
      end
end
end



RSpec.describe InterventionsController, type: :controller do
    
  # describe "GET submission from Intervension controller" do
     
  #   it "get intervention and return a successful response" do
  #     get :index
  #         expect(response).to be_successful
  #   end

  #   it "get intervention and return 200 status" do
  #     get :index
  #         expect(response.status).to eq(200)
  #   end
  # end
  context 'test On Intervention' do

      it "Controller test for the method create" do
      params  =  {
          :author_id=> 1,
          :customer_id=> 1,
          :building_id=> 90,
          :battery_id=> 60,
          :column_id=> 111,
          :elevator_id=> 179,
          :employee_id=> 2,
          :report=> "test",
          }
          post(:create, params: params)
          expect(response.code).to eq "302"
      end

   
  end
    context 'Test on Differents Scenarios ' do

      it "send a customer_id to the building method and return succesful" do
          building = Building.new(customer_id: 96)
              expect(response).to be_successful
              expect(response.status).to eq(200)
      end


      it "send a building_id to the battery method and return succesful" do
          buildingObject = Battery.new(building_id: 95)
              expect(response).to be_successful
              expect(response.status).to eq(200)
      end
      

      it "send a battery_id to the column method and return succesful" do
          building = Column.new(battery_id: 70)
              expect(response).to be_successful
              expect(response.status).to eq(200)
      end
      

      it "send a column_id to the elevator method and return succesful " do
          building = Elevator.new(column_id: 162)
              expect(response).to be_successful
              expect(response.status).to eq(200)
      end
     

      it 'return me an error if battery_id is not selected' do
        intervention = Intervention.new(author_id: 1, customer_id: 1)
            expect(intervention.battery_id).to eq(nil)
      end

    it 'return me an error if the parameter customer_id is not entered ' do
        intervention = Intervention.new(author_id: 1, building_id: 1, battery_id: 5, 
        column_id: 89, elevator_id: 289, employee_id: 5, report: "first test")
            expect(intervention.customer_id).to eq(nil)       
    end

    it 'return me true if all parameters are selected except employee_id ' do
        intervention = Intervention.new(author_id: 1, customer_id: 16, building_id: 74, battery_id: 82, 
        column_id: 142, elevator_id: 381, report: "what the hell am i doing?" )
            expect(intervention.employee_id).to eq(nil)
    end
    
    it 'return me true even if elevator_id, column_id are not selected ' do
        intervention = Intervention.new(author_id: 1, customer_id: 12, building_id: 47, battery_id: 61,
        employee_id: 5, report: "fun")

        expect(intervention).to be_valid
    end
    it 'return me true even if elevator_id is not selected' do
        intervention = Intervention.new(author_id: 1, customer_id: 2, building_id: 4, battery_id: 10, column_id: 20, employee_id: 5, report: "fun?")
            expect(intervention.elevator_id).to eq(nil)
    end

    it 'return me true even when elevator_id and column_id and employee_id are not selected' do
        intervention = Intervention.new(author_id: 1, customer_id: 14, building_id: 61, battery_id: 15, 
        report: "well...")
        
        expect(intervention).to be_valid
    end

    it 'return me true if ALL parameters are selected' do
        intervention = Intervention.new(author_id: 1, customer_id: 100, building_id: 3, battery_id: 41, 
        column_id: 54, elevator_id: 47, employee_id: 5, report: "all"  )
            # expect(intervention).to eq(intervention)
            expect(intervention).to be_valid
    end
     
  end
end
 
