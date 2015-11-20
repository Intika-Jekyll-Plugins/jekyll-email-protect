require 'spec_helper'

describe(JekyllEmailProtect::EmailProtectionFilter) do
$stdout.puts("hello")
  let(:doc) { doc_with_content(content) }
  let(:content)  { "{{ '#{email}' | protect_email }}" }
  let(:output) do
    doc.content = content
    doc.output  = Jekyll::Renderer.new(doc.site, doc).run
  end

  context "simple example address" do
    let(:email) { "example@example.com" }

    it "produces the correct percent-encoded email" do
      expect(output).to match(/%65%78%61%6D%70%6C%65@%65%78%61%6D%70%6C%65\.%63%6F%6D/)
    end
  end

  context "example address with plus and dash" do
    let(:email) { "example-person+spam@example.com" }

    it "produces the correct percent-encoded email" do
      expect(output).to match(/%65%78%61%6D%70%6C%65\-%70%65%72%73%6F%6E\+%73%70%61%6D@%65%78%61%6D%70%6C%65\.%63%6F%6D/)
    end
  end
end
