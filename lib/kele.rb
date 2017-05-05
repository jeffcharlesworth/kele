#require "kele/version.rb"
require 'httparty'
require 'json'

class Kele
  include HTTParty
  @base_uri =  'https://www.bloc.io/api/v1'

  def self.new(e, p)
    response = self.post(@base_uri + '/sessions/', query: { email: "#{e}", password: "#{p}" } )
    @auth_token = response["auth_token"]
    puts response.body
    # cookies('authorization' => @auth_token)
  end

  def self.get_me
    response = get(@base_uri + '/users/me', headers: { 'authorization' => @auth_token })
    body = JSON.parse!(response.body)
    puts body["current_enrollment"]["mentor_id"]
  end

  def self.get_mentor_availability(id)
    available = []
    mentor_availability = get(@base_uri + '/mentors/' + "#{id}" + '/student_availability', headers: { 'authorization' => @auth_token })
    schedule = JSON.parse(mentor_availability.body)
    schedule.each { |x| if x["booked"] != true then available << x end }
    puts available
  end
end
