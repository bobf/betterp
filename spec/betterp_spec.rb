# frozen_string_literal: true

RSpec.describe Betterp do
  let(:path) { Pathname.new(__FILE__).relative_path_from(described_class.root) }
  let(:line_no) { 14 } # Line we call `p('something')` below.

  before { allow($stdout).to receive(:write).with(any_args).and_call_original }

  it 'has a version number' do
    expect(Betterp::VERSION).not_to be_nil
  end

  it 'outputs to stdout' do # rubocop:disable RSpec/MultipleExpectations
    p('something')
    expect($stdout).to have_received(:write) do |arg|
      expect(arg).to include path.to_s
      expect(arg).to include line_no.to_s
    end
  end

  it 'outputs duration when a block is received' do # rubocop:disable RSpec/MultipleExpectations
    p { 'something' }
    expect($stdout).to have_received(:write) do |arg|
      expect(arg).to include '0.0'
    end
  end
end
