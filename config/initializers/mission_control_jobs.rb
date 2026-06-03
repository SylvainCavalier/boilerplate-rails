# Mission Control - Jobs dashboard.
#
# Access is restricted in config/routes.rb to signed-in admins via a Devise
# `authenticate :user, ->(u) { u.admin? }` constraint, so the engine's own
# HTTP basic auth is disabled here to avoid a second prompt.
MissionControl::Jobs.http_basic_auth_enabled = false
