class IndexController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def predict
    d = Daru::DataFrame.new({ Pclass: [params[:Pclass].to_i], Sex: [params[:Sex].to_i], Age: [params[:Age].to_i], SibSp: [params[:SibSp].to_i], Parch: [params[:Parch].to_i], Fare: [params[:Fare].to_f] })
    d[:Fare] = d[:Fare] / FARE_MAX.to_f
    d[:Age] = d[:Age] / AGE_MAX.to_f
    d[:SibSp] = d[:SibSp] / SIBSP_MAX.to_f
    d[:Parch] = d[:Parch] / PARCH_MAX.to_f
    prediction = make_prediction(d)
    @survived = prediction == 1
    puts "survided #{@survived}"
    @correct = params[:Survived].to_i == prediction ? 'correct' : 'incorrect'
    respond_to do |format|
      format.js { render 'predict', :locals => { :survived => @survived, :correct => @correct }, layout: false }
    end
  end
end
