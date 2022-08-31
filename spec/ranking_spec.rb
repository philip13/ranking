# require 'rspec/autorun'
require "ranking"

describe Ranking do
  describe ".get_lines_file" do
    it 'return array of lines of file' do
      file_lines = Ranking.get_lines_file "./spec/test.txt"
      expect(file_lines).to eq(["Line 1", "Line 2"])
    end
  end

  describe ".calculate_points" do
    let(:score_str) do
      [
        "Lions 3, Snakes 3",
        "Tarantulas 1, FC Awesome 0",
        "Lions 1, FC Awesome 1",
        "Tarantulas 3, Snakes 1",
        "Lions 4, Grouches 0"
      ]
    end

    it "return hash with the points of each team" do
      points_by_team = Ranking.calculate_points score_str
      expect(points_by_team["Tarantulas"]).to eq(6)
    end
  end

  describe ".order_by_points" do
    let(:points_hash) do
      {"Lions"=>5, "Snakes"=>1, "Tarantulas"=>6, "FC Awesome"=>1, "Grouches"=>0 }
    end

    it "return ranking ordered from most to least points and alfabetic if have same points" do
      r = Ranking.order_by_points(points_hash)
      expect(r[0]).to eq(["Tarantulas", 6])
      expect(r[2]).to eq(["FC Awesome", 1])
    end
  end

  describe ".get_print_result" do
    let(:order_rank) do 
      [["Tarantulas", 6], ["Lions", 5], ["FC Awesome", 1], ["Snakes", 1], ["Grouches", 0]]
    end

    it "return string formated rusult #(plase). (name_team), ## pt(s)" do
      output_str = Ranking.get_print_results order_rank
      expect(output_str[0]).to eq("1. Tarantulas, 6 pts")
      expect(output_str[2]).to eq("3. FC Awesome, 1 pt")
      expect(output_str[3]).to eq("3. Snakes, 1 pt")

    end
  end
end
