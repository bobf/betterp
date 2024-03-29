# frozen_string_literal: true

require 'betterp'

Betterp.configure do |config|
  config.test_mode = true
end

RSpec::Documentation.configure do |config|
  # Force example tabs to have a consistent height to prevent content jumping.
  # config.consistent_height = false

  # Set a maximum height for example tabs. Tabs will scroll if content exceeds this value.
  # config.max_height = "30rem"

  # Enable or disable the table of contents for each page. This renders a list of all headings in
  # the page, except the main heading.
  # config.table_of_contents = true

  # Enable or disable the index search above the navigation tree.
  # config.index_search = true

  config.context do
    # Define global context here, e.g. add some `let` blocks to make them available in every example.
    #
    # let(:foo) { 'bar' }
  end
end

RSpec.configure do |config|
  # Define RSpec configuration here.
  # Note that your main `spec/spec_helper.rb` is not loaded unless you require it in this file.
end
