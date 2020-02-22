class StocksController < AdminController
  before_action :set_stock, only: %i[show]
  before_action :set_form_dependencies, only: %i[new edit]

  def index
    @stocks = Stock.all
  end

  def show; end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      redirect_to stock_path(@stock)
    else
      render :new
    end
  end

  private

  def set_form_dependencies
    @warehouses = Warehouse.all
    @products = Product.all
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:product_id, :warehouse_id, :count)
  end
end
