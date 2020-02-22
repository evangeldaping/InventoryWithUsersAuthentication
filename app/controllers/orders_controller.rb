class OrdersController < AdminController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.all
  end

  def show
    @order_items = @order.order_items
    @order_item = @order.order_items.build
    @products = Product.all
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      flash.notice = 'Successfully created order.'

      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      flash.notice = 'Successfully updated order.'

      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    @order.destroy!

    redirect_to orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :customer_name)
  end
end
