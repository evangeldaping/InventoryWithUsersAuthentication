class OrderItemsController < AdminController
  before_action :set_order
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
  def destroy
    OrderItem.find(params[:id]).destroy!
    flash.notice = 'Successfully deleted order item!'
    redirect_to order_path(@order)
  end
  private
  def set_order
    @order = Order.find(params[:order_id])
  end
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
