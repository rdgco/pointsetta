class Participant < ApplicationRecord
  belongs_to :pointing_session

  after_create_commit :refresh_participants
  after_update_commit :update_participant

  def display_vote
    if vote.blank?
      "None"
    elsif pointing_session.voting_complete?
      self.vote
    else
      "Voted"
    end
  end

  private

  def update_participant
    broadcast_update_to(self.pointing_session, target: self, partial: "participants/participant", locals: { participant: self })
    if self.pointing_session.voting_complete?
      refresh_participants
    end
    broadcast_update_to(
      self.pointing_session,
      target: "participant_#{self.id}_vote",
      partial: "participants/vote_form",
      locals: { participant: self, pointing_session: self.pointing_session }
    )
  end

  def refresh_participants
    broadcast_update_to(self.pointing_session, target: "participants", partial: "participants/list", locals: { pointing_session: self.pointing_session })
  end
end
