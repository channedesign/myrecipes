 require "test_helper"

class ChefTest < ActiveSupport::TestCase
    
    def setup 
        @chef = Chef.new(chefname: "Bob", email:"bob@bob.com")
    end
    
    test "chef should be valid" do
        assert @chef.valid? 
    end
    
    test "chefname must be present" do 
        @chef.chefname = ""
        assert_not @chef.valid?
    end
        
    test "chefname should not be to long" do 
        @chef.chefname = "a" * 41
        assert_not @chef.valid?
    end
    
    test "chefname should not be to short" do 
        @chef.chefname = "aa"
        assert_not @chef.valid?
    end
    
    test "email must present" do
       @chef.email =  ""
       assert_not @chef.valid?
    end
    
    test "email must be within bound" do
        @chef.email = "a" * 101 + "@example.com" 
        assert_not @chef.valid?
    end
    
    test "email must be unique" do 
      dup_chef = @chef.dup
      dup_chef.email = @chef.email.upcase
      @chef.save
      assert_not dup_chef.valid?
    end
    
    test "email validation should accept valid addresses" do 
        valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@exemple.com first.last@eem.au laura+joe@monk.cm]
        valid_addresses.each do |va|
            @chef.email = va
            assert @chef.valid?, "#{va.inspect} should be valid"
        end
    end
    
    test "email validation should reject invalid addresses" do 
        invalid_addresses = %w[user@exemple,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
        invalid_addresses.each do |ia|
            @chef.email = ia
            assert_not @chef.valid?, "#{ia.inspect} shoud be invalid"
        end
    end
    
end
