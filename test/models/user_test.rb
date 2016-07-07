require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(name: "Example User", 
                     email: "user@example.com",
                     password: "thisIsThePassword",
                     password_confirmation: "thisIsThePassword")
  end

  # Tests concerning user
  test "user should be valid" do
    assert @user.valid?
  end


  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "name should be no more than 64 characters" do
    @user.name = "a" * 65
    assert_not @user.valid?
  end

  # Tests concerning email
  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email should be no more than 255 characters" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@food.COM A_US-reR@foo.bar.org first.laster@foo.jp alicja+dan@baz.ca]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    valid_addresses = %w[user@example,com user_at_com user.name@exmple@another.com foobar@a+b.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be saved as lower-case" do
    mixed_case = "MiXed@CasE.cOm"
    @user.email = mixed_case
    @user.save
    assert_equal(mixed_case.downcase, @user.reload.email)
  end

          # This test also accounts for case sensitive being false
  test "email addresses should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end


  # Tests concerning passwords
  test "password should be present and nonblank" do
    @user.password = @user.password_confirmation = " " * 9
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
