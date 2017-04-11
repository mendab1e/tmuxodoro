require "spec_helper"

MINUTE = 60

describe Pomodoro do
  let(:tomatos) { 8 }
  let(:tomato_time) { 55 * MINUTE }
  let(:rest_time) { 5 * MINUTE }

  let(:pomodoro) do
    described_class.new(
      tomatos: tomatos,
      tomato_time: tomato_time,
      rest_time: rest_time
    )
  end

  before :each do
    Timecop.freeze(Time.now)
    pomodoro.start
  end

  after :each do
    Timecop.return
  end

  describe '#start' do
    context 'reduces tomatos count by 1' do
      subject { pomodoro.tomatos }
      it { should eq(tomatos - 1) }
    end

    context 'set stop_at' do
      subject { pomodoro.stop_at }
      it { should eq Time.now + tomato_time }
    end
  end

  describe '#status' do
    subject { pomodoro.status }
    before :each do
      Timecop.travel(new_time)
    end

    context 'work' do
      let(:passed_time) { 5 * MINUTE }
      let(:new_time) { Time.now + passed_time }
      it { should eq "work: #{((tomato_time - passed_time) / MINUTE).ceil} min\n" }
    end

    context 'rest' do
      let(:passed_rest_time) { 2 * MINUTE }
      let(:passed_time) { passed_rest_time + tomato_time }
      let(:new_time) { Time.now + passed_time }
      it { should eq "rest: #{((rest_time - passed_rest_time) / MINUTE).ceil} min\n" }
    end

    context 'not active' do
      let(:passed_time) { tomato_time + rest_time }
      let(:new_time) { Time.now + passed_time }
      it { should eq "🍅 #{tomatos - 1}\n" }
    end
  end
end
