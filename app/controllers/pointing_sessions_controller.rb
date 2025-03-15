class PointingSessionsController < ApplicationController
  def index
    @pointing_sessions = PointingSession.all.order(created_at: :desc)
    @pointing_session = PointingSession.new(name: Faker::Movie.title)
  end

  def create
    @pointing_session = PointingSession.create(new_pointing_session_params)
    if !@pointing_session.valid?
      puts "Erros: #{@point_session.errors}"
      flash[:error] = "Invalid name"
      redirect_to :index
    else
      flash[:notice] = "Created new pointing session"
      redirect_to pointing_session_url(@pointing_session)
    end
  end

  def update
    @pointing_session = PointingSession.find(params[:id])
    @pointing_session.update!(update_pointing_session_params)
    @pointing_session.participants.each { |participant| participant.update!(vote: nil) }
  end

  def show
    @pointing_session = PointingSession.find(params[:id])
    if session[:participant_id]
      @participant = Participant.find_by(id: session[:participant_id])
    end

    if !@participant || @participant.pointing_session != @pointing_session
      @participant = @pointing_session.participants.create(name: Faker::FunnyName.name, administrator: @pointing_session.participants.empty?)
      session[:participant_id] = @participant.id
      flash[:message] = "Welcome #{@participant.name}"
    end
  end

  private

  def new_pointing_session_params
    params.expect(pointing_session: [ :name ])
  end

  def update_pointing_session_params
    params.expect(pointing_session: [ :topic ])
  end
end
