require "spec_helper"

RSpec.describe TDD do
  it "Has a version number" do
    expect(TDD::VERSION).not_to be nil
  end

  it "There must be a Food class" do
      # Expect "Food" to be an object of class "Class"
      expect( Food.is_a?(Class) ).to be(true)
  end

end
