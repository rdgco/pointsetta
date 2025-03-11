class ParticipantsController < ApplicationController
  def vote
    @participant = Participant.find(params[:id])
    @participant.update!(vote: vote_params[:vote])
  end

  def update
    @participant = Participant.find(params[:id])
    @participant.update!(update_participant_params)
  end


  private

  def vote_params
    params.expect(participant: [ :vote ])
  end

  def update_participant_params
    params.expect(participant: [ :name ])
  end
end
