class StocksController < ApplicationController
  def search
    if params[:stock].present?
      ticker_symbol = params[:stock]
      @stock = Stock.lookup(ticker_symbol)
      if @stock
        respond_to do |format|
          format.js { render "users/_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render "users/_result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render "users/_result" }
      end
    end
  end
end
