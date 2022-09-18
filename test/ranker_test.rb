require_relative "test_helper"

class RankerTest < Minitest::Test
  def test_ranker_exists
    assert Ranker.new
  end

  def test_add_match
    ranker = Ranker.new

    ranker.add_match("Lions 3, Snakes 3")

    assert_equal 1, ranker.matches.size
  end

  def test_calculate_ranking_with_winning_score
    ranker = Ranker.new

    ranker.add_match("FC Awesome 3, Snakes 0")
    ranking = ranker.calculate_ranking

    expected_ranking = <<~RANKING
    1. FC Awesome, 3 pts
    2. Snakes, 0 pts
    RANKING

    assert_equal expected_ranking, ranking
  end

  def test_calculate_ranking_with_different_winning_score
    ranker = Ranker.new

    ranker.add_match("Lions 0, Snakes 3")
    ranking = ranker.calculate_ranking

    expected_ranking = <<~RANKING
    1. Snakes, 3 pts
    2. Lions, 0 pts
    RANKING

    assert_equal expected_ranking, ranking
  end

  def test_calculate_ranking_with_draw
    ranker = Ranker.new

    ranker.add_match("Lions 1, Snakes 1")
    ranking = ranker.calculate_ranking

    expected_ranking = <<~RANKING
    1. Lions, 1 pt
    2. Snakes, 1 pt
    RANKING

    assert_equal expected_ranking, ranking
  end

  def test_calculate_ranking_with_draw_order_alphabetically
    ranker = Ranker.new

    ranker.add_match("Snakes 1, Lions 1")
    ranking = ranker.calculate_ranking

    expected_ranking = <<~RANKING
    1. Lions, 1 pt
    2. Snakes, 1 pt
    RANKING

    assert_equal expected_ranking, ranking
  end

  def test_calculate_ranking_with_multiple_matches
    ranker = Ranker.new

    ranker.add_match("Lions 3, Snakes 3")
    ranker.add_match("Tarantulas 1, FC Awesome 0")
    ranker.add_match("Lions 1, FC Awesome 1")
    ranker.add_match("Tarantulas 3, Snakes 1")
    ranker.add_match("Lions 4, Grouches 0")
    ranking = ranker.calculate_ranking

    expected_ranking = <<~RANKING
    1. Tarantulas, 6 pts
    2. Lions, 5 pts
    3. FC Awesome, 1 pt
    4. Snakes, 1 pt
    5. Grouches, 0 pts
    RANKING

    assert_equal expected_ranking, ranking
  end
end
