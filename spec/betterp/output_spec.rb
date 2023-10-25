# frozen_string_literal: true

RSpec.describe Betterp::Output do
  subject(:output) { described_class.new(raw, source, duration) }

  let(:raw) { 'raw caller info' }
  let(:duration) { nil }
  let(:source) do
    instance_double(
      Betterp::Source,
      path: '/path/to/file.rb',
      line_no: 100,
      method_name: 'test_method'
    )
  end

  it { is_expected.to be_a described_class }

  describe '#formatted' do
    subject(:formatted) { output.formatted(['hello']) }

    its(:size) { is_expected.to be 1 }
    its(:first) { is_expected.to include '/path/to/file.rb' }
    its(:first) { is_expected.to include 'test_method' }
    its(:first) { is_expected.to include 'hello' }
    its(:first) { is_expected.to include "\e[93m" }

    context 'with duration' do
      let(:duration) { 1 }

      its(:first) { is_expected.to include '/path/to/file.rb' }
    end
  end
end
