#require "kele/version.rb"
require 'httparty'

module Kele
  include HTTParty
  base_uri =  'www.bloc.io/api/v1'

  def self.new(e, p)
    response = self.post('https://www.bloc.io/api/v1/sessions/', query: { email: "#{e}", password: "#{p}" } )
    @auth_token = response["auth_token"]
    puts @auth_token
  end

  def self.user
    response = get('https://www.bloc.io/api/v1/users/me')
    puts response
  end
end
