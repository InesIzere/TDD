require './lib/elevator_media/streamer.rb'
require 'json'
require 'net/http'
require 'spec_helper'
require 'rails_helper'

describe ElevatorMedia::Streamer do
    let!(:streamer){ElevatorMedia::Streamer.new}
    
#  In RSpec, describe is used to define an example group. Describe takes one argument, which can either be a string or a class name. The main purpose of this string is for use during the test output. So that you'll know which tests RSpec is referring to.

# For expectations,There are four main parts: expect, then an argument to expect, then a mat we call the method .to, see that .to. and then an argument to the method .to.

# describing advice api
   describe "The api Advice" do
    #  it" is used to define an example. it also accepts a string and has a Ruby block.
     it "If an advice slip is found with the corresponding{id}, a slip object is returned." do
      Daily_Advice= 
       {
        "slip": {
            "id": 35,
            "advice": "Only those who attempt the impossible can achieve the absurd."
        }
       }
             response = JSON.parse(streamer.randomAdvice) 

                 expect(response).to_not eq(nil)
                expect(response).to have_key('slip')
              
         p response
     end
   end
# describing chuck api
  
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
  
 # *************************************Queries *************************************
#  test if i can retrieve queries 

  describe "Get all Details" do
    it "This should query all the buildings" do
        expect(Building).to receive(:all) {[]}
        streamer.getDetails
    end
    it "This should query all the batteries" do
        expect(Battery).to receive(:all) {[]}
        streamer.getDetails
    end
    it "This should query all the elevators" do
        expect(Elevator).to receive(:all) {[]}
        streamer.getDetails
    end
    it "This should query all the columns" do
      expect(Column).to receive(:all) {[]}
        streamer.getDetails
    end
  end


end

# *************************************Quote's Controller*************************************
# in my controller here, in the first example, after we've called GET index, I can expect that the response will have an HTTP status code of 200. This is the most basic test and it lets me know that the page was okay. There was no error. It didn't fail to find an object. It didn't raise any other kind of internal error. Everything came back fine. The second test is to test whether it rendered the status that I expected. I was expecting the response to render the 'index'.  
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

# *************************************Intervention's Controller*************************************
# https://relishapp.com/rspec/rspec-rails/v/5-0/docs/controller-specs

RSpec.describe InterventionsController, type: :controller do
    
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
            expect(intervention).to_not be_valid
      end

    it 'return me an error if the parameter customer_id is not entered ' do
        intervention = Intervention.new(author_id: 1, building_id: 1, battery_id: 5, 
        column_id: 89, elevator_id: 289, employee_id: 5, report: "first test")
            expect(intervention.customer_id).to eq(nil)   
            expect(intervention).to_not be_valid    
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

# ********************************************Lead Model*************************************************
# https://semaphoreci.com/community/tutorials/how-to-test-rails-models-with-rspec
# https://relishapp.com/rspec/rspec-rails/docs/model-specs"Model specs are marked by :type => :model or if you have set config.infer_spec_type_from_file_location! by placing them in spec/models. A model spec is a thin wrapper for an ActiveSupport::TestCase, and includes all of the behavior and assertions that it provides, in addition to RSpec's own behavior and expectations.
# The models are easy to work with, mostly because unlike controllers, there's no request response cycle to worry about. You don't have to worry about rendering templates, or anything like that. We just have an object. And we can create an instance in that object, and then we can poke and prod at it to see if we get the results that we want. As a beginner, they're gonna be the easiest to take on, and I think they're gonna add the most value. While for the most part it's gonna be straight forward, there are a few pointers that I can offer to help you get past some of the common stumbling blocks.


RSpec.describe Lead, :type => :model do
# We add a subject to our specs, which is  the main object under test in this spec file.
    subject {
      described_class.new(:name=> "Anything",
                          :company_name=> "Shimwe",
                          :email=> 'izere5@hotmail.com',
                          :phone=> '123456',
                          :project_name=> "hello",
                          :project_description=> "Lorem ipsum",
                          :department=> 'hi',
                          :message=> 'hell ya'
                         
                          
    )}
#   To get this step working, we need to add the validations of each attribute

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  
    it "is not valid without a name" do
        subject.name = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without a company_name" do
        subject.company_name = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without an email" do
        subject.email = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without a phone" do
        subject.phone = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without an project_name" do
        subject.project_name = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without project_description" do
        subject.project_description = nil
      expect(subject).to_not be_valid
    end
  
    it "is valid without an department" do
        subject.department = nil
      expect(subject).to be_valid
    end
  
    it "is not valid without message" do
        subject.message = nil
      expect(subject).to be_valid
    end
  
    it "is valid without attachment " do
      subject.attachment  = nil
      expect(subject).to be_valid
    end
  end
 
