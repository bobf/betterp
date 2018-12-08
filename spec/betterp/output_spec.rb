# frozen_string_literal: true

RSpec.describe Betterp::Output do
  subject(:output) { described_class.new(raw, source) }

  let(:raw) { 'raw caller info' }
  let(:source) do
    instance_double(
      Betterp::Source,
      path: '/path/to/file.rb',
      line_no: 100,
      method_name: 'test_method'
    )
  end

  it { is_expected.to be_a described_class }

  describe '#format' do
    subject(:format) { output.format(['hello']) }

    its(:size) { is_expected.to eql 1 }
    its(:first) { is_expected.to include '/path/to/file.rb' }
    its(:first) { is_expected.to include 'test_method' }
    its(:first) { is_expected.to include 'hello' }
    its(:first) { is_expected.to include '[33m' }
    its(:first) { is_expected.to end_with '[0m' }
  end
end
