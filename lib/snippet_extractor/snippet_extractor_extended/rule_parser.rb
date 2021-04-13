module SnippetExtractor
  module SnippetExtractorExtended
    SimpleRule = Struct.new(:word, :modifiers)
    MultilineRule = Struct.new(:start_rule, :end_rule)

    class RuleParser
      include Mandate

      initialize_with :rule_text

      MULTILINE_TOKEN = '-->>'.freeze

      def call
        rule_text.lines.
          reject { |line| line.strip.empty? }.
          map { |line| line.delete("\n") }.
          map do |line|
            if line.include? MULTILINE_TOKEN
              multiline_rule line
            else
              simple_rule line
            end
          end
      end

      def simple_rule(line)
        word, modifiers = line.split('\\')
        modifiers = '' if modifiers.nil?

        SimpleRule.new(word, modifiers)
      end

      def multiline_rule(line)
        start_rule, end_rule = line.split('-->>').map { |rule| simple_rule rule }

        MultilineRule.new(start_rule, end_rule)
      end
    end
  end
end