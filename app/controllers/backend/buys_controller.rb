# frozen_string_literal: true
module Backend
  class BuysController < BackendController
    #authorize_resource class: false
    before_action :set_buy, except: [
      :index
    ]

    def index
      authorize! :index, :backendBuysController
      @buys = Buy.all.decorate
    end

    def state_change_accepted
      #authorize! :state_change_accepted, :backendBuysController
      if @buy.accepted!
        flash.now[:notice] = t('change_buy_accepted')
      else
        flash.now[:alert] = t('error_buy_change')
      end
      @buy.decorate
    end

    def state_change_rejected
      #authorize! :state_change_rejected, :backendBuysController
      if @buy.rejected!
        flash.now[:notice] = t('change_buy_rejected')
      else
        flash.now[:alert] = t('error_buy_change')
      end
      @buy.decorate
    end

    def show
      authorize! :show, :backendBuysController
    end

    private

    def set_buy
      @buy = Buy.find(params[:id]).decorate
    end

    def buy_params
      params.require(:buy).permit(:id)
    end
  end
end
