class Ranking
  def self.init(file_path)
    games_str_lines = get_lines_file(file_path)
    points_by_team = calculate_points(games_str_lines)
    
    order_ranking = order_by_points(points_by_team)
    ranking_table = get_print_results order_ranking
    save_ranking ranking_table
  end

  def self.get_lines_file url
    lines_file = []
    file = File.open(url)
    lines_file = file.readlines.map(&:chomp)
    file.close
    lines_file
  end

  def self.calculate_points str_lines
    r_points = {}

    str_lines.each do |g|
      score = game_score_game g

      if score[:home][:goals] == score[:visitor][:goals]
        r_points = add_points(score[:home][:name], 1, r_points)
        r_points= add_points(score[:visitor][:name], 1, r_points)
      elsif score[:home][:goals] > score[:visitor][:goals]
        r_points = add_points(score[:home][:name], 3, r_points)
        r_points = add_points(score[:visitor][:name], 0, r_points)
      else
        r_points= add_points(score[:home][:name], 0, r_points)
        r_points= add_points(score[:visitor][:name], 3, r_points)
      end 
    end
    r_points
  end

  def self.game_score_game str
      g_teams = str.split(', ')
      home_g = g_teams[0].match(/\s\d+/).to_s.to_i
      home_n = g_teams[0].gsub(/\s\d+/, '')

      visitor_g = g_teams[1].match(/\s\d+/).to_s.to_i
      visitor_n = g_teams[1].gsub(/\s\d+/, '')
      score = {
        home: { name: home_n, goals: home_g },
        visitor: { name: visitor_n, goals: visitor_g }
      }
  end

  def self.add_points team_name, points, ranking
    if ranking[team_name].nil?
      ranking[team_name] = points
    else
      ranking[team_name] += points
    end
    ranking
  end

  def self.order_by_points points_hash
    points_hash.sort_by {|k, v| [-v, k]}
  end

  def self.get_print_results order_rank
    plase = 0
    points = -1
    output_str = []
    order_rank.each_with_index do |r, i|
      unless points == r[1]
        plase += 1
      end
      points = r[1]
      output_str << "#{plase}. #{r[0]}, #{points} #{points > 1 ? 'pts' : 'pt'}"
    end

    output_str
  end

  def self.save_ranking str_arr
    out_text_file = str_arr.join(" \n")
    puts out_text_file
    Dir.mkdir('./output') unless Dir.exist?('./output')
    file = File.write("./output/ranking.txt", out_text_file)
    puts "The ranking was record on: './output/ranking.txt'"
  end
end





