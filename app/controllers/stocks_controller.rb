class StocksController < AdminController
  before_action :set_stock, only: %i[show]
  before_action :set_form_dependencies, only: %i[new edit]
  before_action :set_warehouse
  
  # def index
  #   @stocks = Stock.all
  # end
  #
  # def show; end
  #
  # def new
  #   @stock = Stock.new
  # end

  def create
    @stock = @warehouse.stocks.build(stock_params)

    if @stock.save
      redirect_to warehouse_path(@warehouse)
    else
      render :new
    end
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:warehouse_id])
  end

  # def set_form_dependencies
  #   @warehouses = Warehouse.all
  #   @products = Product.all
  # end
  #
  # def set_stock
  #   @stock = Stock.find(params[:id])
  # end

  def stock_params
    params.require(:stock).permit(:product_id, :count)
  end
end
