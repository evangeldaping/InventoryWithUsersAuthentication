class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_item, only: %i[edit update destroy]
  before_action :set_dependencies, only: %i[edit]
  def create
    @order_item = @order.order_items.find_or_initialize_by(product_id: order_item_params[:product_id].to_i)
    if @order_item.new_record?
      @order_item.quantity = order_item_params[:quantity].to_i
    else
      @order_item.quantity += order_item_params[:quantity].to_i
    end
    @order_item.save!
    redirect_to order_path(@order)
  end
  def edit; end
  def update
    respond_to do |format|
      if @order_item.update(order_items_params)
        format.html { redirect_to order_path(@order), notice: 'Order Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  def destroy
    @order_item.destroy
    render json: { id: @order_item.id }
  end
  private
  def set_order
    @order = Order.find(params[:order_id])
  end
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end
  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
  def set_dependencies
    @products = Product.all
  end
end
