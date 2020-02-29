import React, { Component } from "react";
import PropTypes from "prop-types";
import { Table, Button, ButtonGroup, Form, Alert } from "react-bootstrap";
import _ from "lodash";
import axios from "../config/axios";
class Order extends Component {
  constructor(props) {
    super(props);
    this.state = {
      message: null,
      orderItems: _.mapKeys(props.orderItems, orderItem => orderItem.id),
      productId: 1,
      qty: 1,
      variant: null
    };
  }
  deleteOrderItem = async orderItemId => {
    try {
      let { data, status } = await axios.delete(
        `/orders/${this.props.id}/order_items/${orderItemId}`
      );
      if (status === 200) {
        this.setState(({ orderItems }) => ({
          orderItems: _.filter(
            orderItems,
            orderItem => !(orderItem.id === data.id)
          ),
          message: "Successfully deleted order item.",
          variant: "danger"
        }));
      }
    } catch (error) {
      alert("Can't delete item.");
    }
  };
  createOrderItem = async e => {
    e.preventDefault();
    try {
      let { data, status } = await axios.post(
        `/orders/${this.props.id}/order_items`,
        {
          order_item: {
            product_id: this.state.productId,
            quantity: this.state.qty
          }
        }
      );
      if (status === 200) {
        this.setState(({ orderItems }) => ({
          orderItems: { ...orderItems, [data.id]: data },
          message: "Successfully created order item.",
          variant: "success"
        }));
      }
    } catch (error) {
      alert("Can't create order item.");
    }
  };
  render = () => (
    <>
      {!_.isNull(this.state.message) && !_.isNull(this.state.variant) && (
        <Alert variant={this.state.variant}>
          <Alert.Heading>{this.state.message}</Alert.Heading>
          <Button
            onClick={() => this.setState({ message: null, variant: null })}
          >
            Close
          </Button>
        </Alert>
      )}
      <Form onSubmit={this.createOrderItem}>
        <Form.Group>
          <Form.Control
            as="select"
            onChange={e => this.setState({ productId: e.target.value })}
            value={this.state.productId}
          >
            {_.map(this.props.products, product => (
              <option value={product.id} key={product.id}>
                {product.name}
              </option>
            ))}
          </Form.Control>
          <Form.Group>
            <Form.Control
              type="number"
              placeholder="Qty"
              value={this.state.qty}
              onChange={e => this.setState({ qty: e.target.value })}
            />
          </Form.Group>
        </Form.Group>
        <Button type="submit" variant="success">
          Add Order Item
        </Button>
      </Form>
      <Table striped hover>
        <thead>
          <tr>
            <td>SKU</td>
            <td>Name</td>
            <td>Qty</td>
            <td>Actions</td>
          </tr>
        </thead>
        <tbody>
          {_.map(
            this.state.orderItems,
            orderItem =>
              orderItem.id && (
                <tr key={orderItem.id}>
                  <td>{orderItem.product.sku}</td>
                  <td>{orderItem.product.name}</td>
                  <td>{orderItem.quantity}</td>
                  <td>
                    <ButtonGroup>
                      <Button variant="primary">&#9998;</Button>
                      <Button
                        variant="danger"
                        onClick={() => this.deleteOrderItem(orderItem.id)}
                      >
                        &#128465;
                      </Button>
                    </ButtonGroup>
                  </td>
                </tr>
              )
          )}
        </tbody>
      </Table>
    </>
  );
}
Order.propTypes = {
  id: PropTypes.number,
  product: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number,
      name: PropTypes.string
    })
  ),
  orderItems: PropTypes.arrayOf(
    PropTypes.shape({
      quantity: PropTypes.number,
      id: PropTypes.number,
      product: PropTypes.shape({
        name: PropTypes.string,
        sku: PropTypes.string
      })
    })
  )
};
export default Order;
