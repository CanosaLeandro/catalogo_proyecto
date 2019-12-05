# frozen_string_literal: true

module Frontend
  class BuysController < FrontendController
    #before_action :authorize_buy
    def index
      @buys = current_user.buys
    end

    def show
      @buy = Buy.find(params[:id]).decorate
    end

    private

    def buy_params
      params.require(:buy).permit(:id)
    end
  end
end
