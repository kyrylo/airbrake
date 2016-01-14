PhusionPassenger.require_passenger_lib('loader_shared_helpers')

module PhusionPassenger
  module LoaderSharedHelpers
    alias_method :about_to_abort_without_airbrake, :about_to_abort

    def about_to_abort(*args)
      exception = args.last
      return unless exception.is_a?(Exception)

      params = {
        component: "PhusionPassenger/#{PhusionPassenger::VERSION_STRING}",
        args: args
      }
      Airbrake.notify_sync(exception, params, :passenger)

    ensure
      about_to_abort_without_airbrake(*args)
    end
  end
end
