class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def euclidean_distance(point1, point2)
    Math.sqrt(point1.zip(point2).reduce(0) { |sum, p| sum + (p[0] - p[1]) ** 2 })
  end

  def parametric_df
    @@parametric_df ||= PARAMETRIC_DF
  end

  def test_df
    @@test_df ||= TEST_DF
  end

  def y_par
    @@y_par ||= Y_PAR
  end

  def y_test
    @@y_test ||= Y_TEST
  end

  def make_prediction(test_vect)
    b = []
    new_d = Matrix.build(1, parametric_df.shape[0]) { |row, col| euclidean_distance(test_vect.row_at(0), parametric_df.row_at(col)) }.to_a
    right_pred = 0
    [0, 1].each do |cls|
      clf_ind = y_par.where(y_par.eq(cls)).index.to_a
      b[cls] = new_d[0].values_at(*clf_ind).min(K).sum
    end
    p b
    b.rindex(b.min)
  end
end
