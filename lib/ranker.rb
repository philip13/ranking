class Ranker
  attr_reader :matches

  def initialize
    @matches = []
    @team_points = Hash.new(0)
  end

  def add_match(match)
    @matches << parse_match(match)
  end

  def calculate_ranking
    ranking = @team_points.sort_by { |name, points| [-points, name[0].ord] }.to_h
    output_ranking(ranking)
  end

  private

  def output_ranking(ranking)
    output = ""
    ranking.each_with_index do |(team, points), idx|
      output += "#{idx + 1}. #{team}, #{points} #{points_str(points)}\n"
    end
    output
  end

  def parse_match(match)
    team1, team1_goals, team2, team2_goals = match.match(/(?<team1>[\w\s]+)\s(?<team1_goals>\d+),\s(?<team2>[\w\s]+)\s(?<team2_goals>\d+)/).captures

    if team1_goals.to_i > team2_goals.to_i
      @team_points[team1] += 3
      @team_points[team2] += 0
    elsif team1_goals.to_i == team2_goals.to_i
      @team_points[team1] += 1
      @team_points[team2] += 1
    else
      @team_points[team1] += 0
      @team_points[team2] += 3
    end
  end

  def points_str(points)
    if points == 1
      "pt"
    else
      "pts"
    end
  end
end
