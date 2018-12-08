# frozen_string_literal: true

RSpec.describe Betterp do
  it 'has a version number' do
    expect(Betterp::VERSION).not_to be nil
  end

  it 'outputs to stdout' do
    path = Pathname.new(__FILE__).relative_path_from(Betterp.root)
    line_no = 18 # Line we call `p('something')` below.
    expect(STDOUT)
      .to receive(:write)
      .with(any_args) do |arg|
        expect(arg).to include path.to_s
        expect(arg).to include line_no.to_s
      end

    p('something')
  end
end
