# Be sure to restart your server when you modify this file.

# Application-wide Content Security Policy (replaces the secure_headers gem).
# See https://guides.rubyonrails.org/security.html#content-security-policy-header
# Tighten these directives per project (e.g. add CDN/analytics hosts).
Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https
    policy.style_src   :self, :https
    # Allow @vite/websocket-style live connections only if you add a bundler dev server.
    # policy.connect_src :self, :https
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Use nonces for inline <script>/<style> (Turbo and importmap tags pick these up).
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src style-src]

  # Set to true to only report violations (no enforcement) while tuning the policy.
  # config.content_security_policy_report_only = true
end
