# Mission Control - Jobs dashboard (mounted at /jobs in config/routes.rb).
#
# Secure by default: the engine returns 401 unless HTTP basic auth credentials
# are configured. Set them in production via env vars.
MissionControl::Jobs.http_basic_auth_user = ENV["MISSION_CONTROL_JOBS_USER"]
MissionControl::Jobs.http_basic_auth_password = ENV["MISSION_CONTROL_JOBS_PASSWORD"]

# Browse the dashboard without credentials in development.
# TODO (Phase 5): replace HTTP basic auth with a Devise admin constraint.
MissionControl::Jobs.http_basic_auth_enabled = false if Rails.env.development?
