# frozen_string_literal: true

RSpec.describe Betterp::Source do
  subject(:source) { described_class.new(caller_source, base_path) }

  let(:caller_source) { "#{path}:100:in `test_method'" }
  let(:path) { '/path/to/file.rb' }
  let(:base_path) { '/path/to/' }

  it { is_expected.to be_a described_class }

  its(:path) { is_expected.to eql 'file.rb' }
  its(:line_no) { is_expected.to eql 100 }
  its(:method_name) { is_expected.to eql 'test_method' }

  context 'path is not a file' do
    let(:path) { '(irb)' }
    its(:path) { is_expected.to eql '(irb)' }
  end
end
