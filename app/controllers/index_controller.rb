class IndexController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
    end

    def predict
        d = Daru::DataFrame.new({Pclass: [params[:Pclass].to_i], Sex: [params[:Sex].to_i], Age: [params[:Age].to_i], SibSp: [params[:SibSp].to_i], Parch: [params[:Parch].to_i], Fare: [params[:Fare].to_f]})
        d[:Fare] = d[:Fare] / fare_max
        d[:Age] = d[:Age] / age_max
        p age_max
        p fare_max
        @survived = make_prediction(d) == 1
        respond_to do |format|
            format.js{ render 'predict', :locals => { :survived => @survived }, layout: false }
          end
    end
end
