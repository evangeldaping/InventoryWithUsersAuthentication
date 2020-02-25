class WarehousesController < AdminController
  before_action :assign_warehouse, only: %i[show edit update destroy]

  def index
    @warehouses = Warehouse.all
  end

  def show
    @stock = @warehouse.stocks.build
    @products = Product.all
  end

  def edit; end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      flash.notice = 'Successfully created a warehouse.'

      redirect_to warehouse_path(@warehouse)
    else
      render :new
    end
  end

  def update
    if @warehouse.update(warehouse_params)
      flash.notice = 'Successfully updated warehouse.'

      redirect_to warehouse_path(@warehouse)
    else
      render :edit
    end
  end

  def destroy
    @warehouse.destroy!

    flash.notice = "Successfully deleted warehouse #{@warehouse.id}."
    redirect_to warehouses_path
  end

  private

  def assign_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:street, :city, :province)
  end
end
