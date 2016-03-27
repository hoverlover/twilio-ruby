module Twilio
  module TwiML
    class Response

      attr_reader :text
      alias_method :to_xml , :text

      def initialize(options = {}, &block)
        xml = Builder::XmlMarkup.new
        xml.instruct! :xml, { :version => "1.0", :encoding => "UTF-8" }.merge(options)
        @text = xml.Response &block
      end

    end
  end
end
