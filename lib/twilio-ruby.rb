require 'net/http'
require 'net/https'
require 'builder'
require 'multi_json'
require 'cgi'
require 'openssl'
require 'base64'
require 'forwardable'
require 'jwt'
require 'active_support/all'

require 'twilio-ruby/version' unless defined?(Twilio::VERSION)
require 'twilio-ruby/util'
require 'twilio-ruby/util/capability'
require 'twilio-ruby/util/client_config'
require 'twilio-ruby/util/configuration'
require 'twilio-ruby/util/request_validator'
require 'twilio-ruby/util/access_token'
require 'twilio-ruby/twiml/response'
require 'twilio-ruby/rest/errors'
require 'twilio-ruby/rest/utils'
require 'twilio-ruby/rest/list_resource'
require 'twilio-ruby/rest/instance_resource'
require 'twilio-ruby/task_router/capability'

require 'twilio-ruby/resources/conversations/conversation.rb'
require 'twilio-ruby/resources/conversations/conversation/in_progress.rb'
require 'twilio-ruby/resources/conversations/conversation/participant.rb'
require 'twilio-ruby/resources/conversations/conversation/completed.rb'
require 'twilio-ruby/resources/lookups/phone_number.rb'
require 'twilio-ruby/resources/monitor/alert.rb'
require 'twilio-ruby/resources/monitor/event.rb'
require 'twilio-ruby/resources/pricing/voice.rb'
require 'twilio-ruby/resources/pricing/voice/number.rb'
require 'twilio-ruby/resources/pricing/voice/country.rb'
require 'twilio-ruby/resources/pricing/phone_number.rb'
require 'twilio-ruby/resources/pricing/phone_number/country.rb'
require 'twilio-ruby/resources/taskrouter/workspace.rb'
require 'twilio-ruby/resources/taskrouter/workspace/activity.rb'
require 'twilio-ruby/resources/taskrouter/workspace/event.rb'
require 'twilio-ruby/resources/taskrouter/workspace/task.rb'
require 'twilio-ruby/resources/taskrouter/workspace/task/reservation.rb'
require 'twilio-ruby/resources/taskrouter/workspace/task_queue.rb'
require 'twilio-ruby/resources/taskrouter/workspace/task_queue/list_statistics.rb'
require 'twilio-ruby/resources/taskrouter/workspace/task_queue/instance_statistics.rb'
require 'twilio-ruby/resources/taskrouter/workspace/worker.rb'
require 'twilio-ruby/resources/taskrouter/workspace/worker/list_statistics.rb'
require 'twilio-ruby/resources/taskrouter/workspace/worker/instance_statistics.rb'
require 'twilio-ruby/resources/taskrouter/workspace/workflow.rb'
require 'twilio-ruby/resources/taskrouter/workspace/workflow/statistics.rb'
require 'twilio-ruby/resources/taskrouter/workspace/statistics.rb'
require 'twilio-ruby/resources/v2010/account.rb'
require 'twilio-ruby/resources/v2010/account/address.rb'
require 'twilio-ruby/resources/v2010/account/address/dependent_phone_number.rb'
require 'twilio-ruby/resources/v2010/account/application.rb'
require 'twilio-ruby/resources/v2010/account/authorized_connect_app.rb'
require 'twilio-ruby/resources/v2010/account/available_phone_number.rb'
require 'twilio-ruby/resources/v2010/account/available_phone_number/local.rb'
require 'twilio-ruby/resources/v2010/account/available_phone_number/toll_free.rb'
require 'twilio-ruby/resources/v2010/account/available_phone_number/mobile.rb'
require 'twilio-ruby/resources/v2010/account/call.rb'
require 'twilio-ruby/resources/v2010/account/call/feedback_summary.rb'
require 'twilio-ruby/resources/v2010/account/call/recording.rb'
require 'twilio-ruby/resources/v2010/account/call/notification.rb'
require 'twilio-ruby/resources/v2010/account/call/feedback.rb'
require 'twilio-ruby/resources/v2010/account/conference.rb'
require 'twilio-ruby/resources/v2010/account/conference/participant.rb'
require 'twilio-ruby/resources/v2010/account/connect_app.rb'
require 'twilio-ruby/resources/v2010/account/incoming_phone_number.rb'
require 'twilio-ruby/resources/v2010/account/incoming_phone_number/local.rb'
require 'twilio-ruby/resources/v2010/account/incoming_phone_number/mobile.rb'
require 'twilio-ruby/resources/v2010/account/incoming_phone_number/toll_free.rb'
require 'twilio-ruby/resources/v2010/account/message.rb'
require 'twilio-ruby/resources/v2010/account/message/media.rb'
require 'twilio-ruby/resources/v2010/account/notification.rb'
require 'twilio-ruby/resources/v2010/account/outgoing_caller_id.rb'
require 'twilio-ruby/resources/v2010/account/queue.rb'
require 'twilio-ruby/resources/v2010/account/queue/member.rb'
require 'twilio-ruby/resources/v2010/account/recording.rb'
require 'twilio-ruby/resources/v2010/account/recording/transcription.rb'
require 'twilio-ruby/resources/v2010/account/sandbox.rb'
require 'twilio-ruby/resources/v2010/account/sip.rb'
require 'twilio-ruby/resources/v2010/account/sip/domain.rb'
require 'twilio-ruby/resources/v2010/account/sip/domain/ip_access_control_list_mapping.rb'
require 'twilio-ruby/resources/v2010/account/sip/domain/credential_list_mapping.rb'
require 'twilio-ruby/resources/v2010/account/sip/ip_access_control_list.rb'
require 'twilio-ruby/resources/v2010/account/sip/ip_access_control_list/ip_address.rb'
require 'twilio-ruby/resources/v2010/account/sip/credential_list.rb'
require 'twilio-ruby/resources/v2010/account/sip/credential_list/credential.rb'
require 'twilio-ruby/resources/v2010/account/sms.rb'
require 'twilio-ruby/resources/v2010/account/sms/sms_message.rb'
require 'twilio-ruby/resources/v2010/account/sms/short_code.rb'
require 'twilio-ruby/resources/v2010/account/token.rb'
require 'twilio-ruby/resources/v2010/account/transcription.rb'
require 'twilio-ruby/resources/v2010/account/usage.rb'
require 'twilio-ruby/resources/v2010/account/usage/record.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/all_time.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/daily.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/last_month.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/monthly.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/this_month.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/today.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/yearly.rb'
require 'twilio-ruby/resources/v2010/account/usage/record/yesterday.rb'
require 'twilio-ruby/resources/v2010/account/usage/trigger.rb'

require 'twilio-ruby/compatibility/v2010/account/call/feedback.rb'
require 'twilio-ruby/compatibility/v2010/account/queue/member.rb'

Dir[File.dirname(__FILE__) + "/twilio-ruby/compatibility/**/*.rb"].each do |file|
  require file
end

require 'twilio-ruby/rest/v2010_client'
require 'twilio-ruby/rest/conversations_client'
require 'twilio-ruby/rest/taskrouter_client'
require 'twilio-ruby/rest/lookups_client'
require 'twilio-ruby/rest/pricing_client'
require 'twilio-ruby/rest/monitor_client'
require 'rack/twilio_webhook_authentication'

module Twilio
  extend SingleForwardable

  def_delegators :configuration, :account_sid, :auth_token

  ##
  # Pre-configure with account SID and auth token so that you don't need to
  # pass them to various initializers each time.
  def self.configure(&block)
    yield configuration
  end

  ##
  # Returns an existing or instantiates a new configuration object.
  def self.configuration
    @configuration ||= Util::Configuration.new
  end
  private_class_method :configuration
end