require 'rails_helper'

RSpec.describe Parking, type: :model do
  describe ".validate_end_at_with_amount" do

    # it "is invalid without amount" do
    #   parking = Parking.new( :parking_type => "guest",
    #                          :start_at => Time.now - 6.hours,
    #                          :end_at => Time.now )
    #   expect( parking ).to_not be_valid
    # end

    it "is invalid without end_at" do
      parking = Parking.new( :parking_type => "guest",
                             :start_at => Time.now - 6.hours,
                             :amount => 999 )
      expect( parking ).to_not be_valid
    end

  end

  describe ".calculate_amount" do
    before do
      # 把每个测试都会用到的 @time 提取出来，这个 before 区块会在这个 describe 内的所有测试前执行
      @time = Time.new(2017,3, 27, 8, 0, 0)  # 固定一个时间比 Time.now 更好，这样每次跑测试才鞥确保一样的结果
    end

    context "guest" do
      before do
        # 把每个测试都会用到的 @parking 提取出来， 这个 before 区块会在这个 context 内的所有测试前执行
        @parking = Parking.new( :parking_type => "guest", :user => @user, :start_at => @time )
      end

      it "30 mins should be ￥2" do
      # it "30 mins should be ￥2", :focus => true do
        # t = Time.now
        # parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 30.minutes )
        # parking.calculate_amount
        # expect(parking.amount).to eq(200)
        @parking.end_at = @time + 30.minutes
        @parking.save
        expect(@parking.amount).to eq(200)
      end

      it "60 mins should be ￥2" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 60.minutes )
        # parking.calculate_amount
        # expect( parking.amount ).to eq(200)
        @parking.end_at = @time + 60.minutes
        @parking.save
        expect(@parking.amount).to eq(200)
      end

      it "61 mins should be ￥3" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 61.minutes )
        # parking.calculate_amount
        # expect( parking.amount ).to eq(300)
        @parking.end_at = @time + 61.minutes
        @parking.save
        expect(@parking.amount).to eq(300)
      end

      it "90 mins should be ￥3" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 90.minutes )
        # parking.calculate_amount
        # expect( parking.amount ).to eq(300)
        @parking.end_at = @time + 90.minutes
        @parking.save
        expect(@parking.amount).to eq(300)
      end

      it "120 mins should be ￥4" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 120.minutes )
        # parking.calculate_amount
        # expect( parking.amount ).to eq(400)
        @parking.end_at = @time + 120.minutes
        @parking.save
        expect(@parking.amount).to eq(400)
      end
    end

    context "short-term" do
      before do
        # 把每个测试都会用到的 @user 和 @parking 提取出来
        @user = User.create( :email => "test@example.com", :password => "12345678" )
        @parking = Parking.new( :parking_type => "short-term", :user => @user, :start_at => @time )
      end

      it "30 mins should be ￥2" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "short-term", :start_at => t, :end_at => t + 30.minutes )
        # parking.user = User.create(:email => "test@example.com", :password => "12345678")
        # parking.calculate_amount
        # expect(parking.amount).to eq(200)
        @parking.end_at = @time + 30.minutes
        @parking.save
        expect(@parking.amount).to eq(200)
      end

      it "60 mins should be ￥2" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "short-term", :start_at => t, :end_at => t + 60.minutes )
        # parking.user = User.create(:email => "test@example.com", :password => "12345678")
        # parking.calculate_amount
        # expect( parking.amount ).to eq(200)
        @parking.end_at = @time + 60.minutes
        @parking.save
        expect( @parking.amount ).to eq(200)
      end

      it "61 mins should be ￥2.5" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "short-term", :start_at => t, :end_at => t + 61.minutes )
        # parking.user = User.create(:email => "test@example.com", :password => "12345678")
        # parking.calculate_amount
        # expect( parking.amount ).to eq(250)
        @parking.end_at = @time + 61.minutes
        @parking.save
        expect( @parking.amount ).to eq(250)
      end

      it "90 mins should be ￥2.5" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "short-term", :start_at => t, :end_at => t + 90.minutes )
        # parking.user = User.create(:email => "test@example.com", :password => "12345678")
        # parking.calculate_amount
        # expect( parking.amount ).to eq(250)
        @parking.end_at = @time + 90.minutes
        @parking.save
        expect( @parking.amount ).to eq(250)
      end

      it "120 mins should be ￥3" do
        # t = Time.now
        # parking = Parking.new( :parking_type => "short-term", :start_at => t, :end_at => t + 120.minutes )
        # parking.user = User.create(:email => "test@example.com", :password => "12345678")
        # parking.calculate_amount
        # expect( parking.amount ).to eq (300)
        @parking.end_at = @time + 120.minutes
        @parking.save
        expect( @parking.amount ).to eq(300)
      end
    end

  end

end
