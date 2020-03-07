class StocksController < AdminController
  before_action :set_stock, only: %i[show]
  before_action :set_form_dependencies, only: %i[new edit]
  before_action :set_warehouse
  def index
    @stocks = Stock.all
  end

  def show; end

  def new
    @stock = Stock.new
  end
  #
  # def create
  #   @stock = @warehouse.stocks.build(stock_params)
  #
  #   if @stock.save
  #     redirect_to warehouse_path(@warehouse)
  #   else
  #     render :new
  #   end
  # end

  def create
    @stock = @warehouse.stocks.find_or_initialize_by(product_id: stock_params[:product_id].to_i)
    if @stock.new_record?
      @stock.count = stock_params[:count].to_i
    else
      @stock.count += stock_params[:count].to_i
    end
    if @stock.save
      render json: @stock.as_json(
        only: %i[id count],
        include: {
          product: {
            only: %i[sku name]
          }
        }
      )
    else
      render json: { errors: @stocks.errors }, status: :unprocessable_entity
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
