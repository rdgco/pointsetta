class PointingSession < ApplicationRecord
  has_many :participants,  dependent: :destroy
  after_update_commit :update_topic

  scope :stale, -> { where("updated_at <= ?", DateTime.now - 30.minutes) }

  module Constants
    Status = [
      WAITING = "WAITING",
      COMPLETED = "COMPLETED",
      VOTING = "VOTING"
    ].freeze
  end

  def refresh_topic(topic:)
    participants.each { |p| p.update!(vote: nil) }
    self.update!(topic:)
  end

  def status
    if self.topic.nil?
      Constants::Status::WAITING
    elsif self.participants.count  { |p| p.vote.nil? }
      Constants::Status::COMPLETED
    else
      Constants::Status::VOTING
    end
  end

  def voting_complete?
    participants.where(vote: nil).empty?
  end

  def stale?
    updated_at <= DateTime.now - 1.hour
  end

  private

  def update_topic
    broadcast_update_to(self, target: self, html: "<h3> Topic: #{self.topic} </h3>")
  end
end
