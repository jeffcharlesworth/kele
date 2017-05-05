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
  end
end
