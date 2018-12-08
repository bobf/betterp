# frozen_string_literal: true

RSpec.describe Betterp do
  it 'has a version number' do
    expect(Betterp::VERSION).not_to be nil
  end

  it 'outputs to stdout' do
    path = __FILE__
    line_no = 19 # Line we call `p('something')` below.
    expect(STDOUT)
      .to receive(:write)
      .with(any_args) do |arg|
        expect(arg).to include "#{path}:#{line_no}"
        expect(arg).to include "\e[36"
        expect(arg).to include %Q{\e[0m\"something"\n}
      end

    p('something')
  end
end
