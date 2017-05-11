require 'httparty'
require 'json'

module Roadmap
  include HTTParty

  def self.get_roadmap(id = nil)
    roadmap = get($base + "/roadmaps/#{id || $roadmap_id}", $auth_token)
#    JSON.parse!(roadmap.body)
    JSON.pretty_generate(roadmap)
  end

  def self.get_checkpoint(id)
    checkpoint = get($base + "/checkpoints/#{id}", $auth_token)
    JSON.parse!(checkpoint.body)
  end

  def self.create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    options = $auth_token
    options[:query] = {
      assignment_branch: assignment_branch,
      assignment_commit_link: assignment_commit_link,
      checkpoint_id: checkpoint_id,
      comment: comment,
      enrollment_id: enrollment_id
    }
    submission = post($base + "/checkpoint_submissions", options)
  end
end
