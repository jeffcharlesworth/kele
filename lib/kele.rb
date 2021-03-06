#require "kele/version.rb"
require 'httparty'
require 'json'
require_relative 'roadmap.rb'

class Kele
  include HTTParty
  include Roadmap

  $base =  'https://www.bloc.io/api/v1'

  def self.new(e, p)
    response = self.post($base + '/sessions/', query: { email: "#{e}", password: "#{p}" } )
    $auth_token = { headers: { 'authorization' => response["auth_token"] } }
    puts response.body
    # cookies('authorization' => @auth_token)
  end

  def self.get_me
    response = get($base + '/users/me', $auth_token)
    body = JSON.parse!(response.body)
    $mentor_id = response['current_enrollment']['mentor_id']
    $roadmap_id = response['current_enrollment']['roadmap_id']
    puts JSON.pretty_generate(body)
  end

  def self.get_mentor_availability(id = nil)
    available = []
    mentor_availability = get($base + '/mentors/' + "#{id || $mentor_id}" + '/student_availability', $auth_token)
    schedule = JSON.parse(mentor_availability.body)
    schedule.each { |x| if x["booked"] != true then available << x end }
    puts available
  end

  def self.get_messages(page)
    options = $auth_token
    options[:query] = { "page" => page }
    messages =  get($base + '/message_threads/', options )
  end

  def self.send_message(sender, recipient_id, subject, stripped_text, token = nil)
    options = $auth_token
    options[:query] = {
      "sender" => sender,
      "recipient_id" => recipient_id,
      "subject" => subject,
      "stripped-text" => stripped_text
    }
    if token != nil then options[:query]["token"] = token end
    post($base + "/messages", options)
  end
end
