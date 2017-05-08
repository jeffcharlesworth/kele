require 'httparty'
require 'json'

module Roadmap
  include HTTParty

  def self.get_roadmap(id = nil)
    roadmap = get($base + "/roadmaps/#{id || $roadmap_id}", $auth_token)
    JSON.parse!(roadmap.body)
  end

  def self.get_checkpoint(id)
    checkpoint = get($base + "/checkpoints/#{id}", $auth_token)

  end
end
