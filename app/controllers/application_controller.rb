class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  K = 9

  def index

  end

  def get_df(path, range)
    Daru::DataFrame.from_csv(path)[ 'Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Fare'].row_at(range).replace_values('male', 0).replace_values('female', 1).filter_rows{ |row| row['Age'] }
  end

  def euclidean_distance(point1, point2)
    Math.sqrt(point1.zip(point2).reduce(0) { |sum, p| sum + (p[0] - p[1]) ** 2 })
  end

  def fare_max
    @@fare_max ||= Daru::DataFrame.from_csv("train.csv")['Fare'].max()
  end

  def age_max
    @@age_max ||= Daru::DataFrame.from_csv("train.csv")['Age'].max()
  end

  def get_df(path, range)
    d = Daru::DataFrame.from_csv(path)[ 'Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Fare', 'Survived'].row_at(range).replace_values('male', 0).replace_values('female', 1).filter_rows{ |row| row['Age'] }
    d['new_index'] = (0...d.shape[0])
    d.set_index('new_index')
    return [d['Survived'], d['Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Fare']]
  end

  def parametric_df
    @@parametric_df ||= begin
        _, d = get_df('train.csv', 376..750)
        d['Fare'] = d['Fare'] / fare_max
        d['Age'] = d['Age'] / age_max
        d
    end
  end

  def y_par
    @@y_par ||= begin
        y, _ = get_df('train.csv', 376..750)
        y
    end
  end

  def make_prediction(test_vect)
    b = []
    new_d = Matrix.build(1, parametric_df.shape[0]) {|row, col| euclidean_distance(test_vect.row_at(0), parametric_df.row_at(col))}.to_a
    right_pred = 0
    [0, 1].each do |cls|
        clf_ind = y_par.where(y_par.eq(cls)).index.to_a
        b[cls] = new_d[0].values_at(*clf_ind).min(K).sum
    end
    b.rindex(b.min)
  end
end
