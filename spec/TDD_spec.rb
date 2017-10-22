require "spec_helper"

RSpec.describe TDD do
  it "has a version number" do
    expect(TDD::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
