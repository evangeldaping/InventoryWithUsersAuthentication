class OrdersController < AdminController
  before_action :set_orders, only: %i[show destroy edit update]
  before_action :set_dependencies, only: %i[new edit show update create]
  def index
    @orders = Order.all
  end
  def new
    @order = Order.new
  end

  def show
    @order_item = @order.order_items.new

    respond_to do |format|
      format.json { render json: @order }
      format.html
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash.notice = 'Successfully created an order!'
      redirect_to order_path(@order)
    else
      render :new
    end
  end
  
  def edit; end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order #{@order.id} was successfully deleted." }
    end
  end

  private

  def set_orders
    @order = Order.find(params[:id])
  end
  def set_dependencies
    @warehouses = Warehouse.all
    @products = Product.all
  end
  def order_params
    params.require(:order).permit(:warehouse_id, :customer_name)
  end
