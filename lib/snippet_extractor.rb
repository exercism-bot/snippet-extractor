require 'mandate'

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module SnippetExtractor
  def self.process_request(event:, context:)
    ProcessRequest.(event, context)
  end
end
