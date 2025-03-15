class DestroyStalePointingSessionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    PointingSession.stale.each(&:destroy)
  end
end
